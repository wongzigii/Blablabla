//
//  BLXMPPTool.m
//  Blablabla
//
//  Created by Wongzigii on 15/3/21.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "BLXMPPTool.h"
#import "Constant.h"
#import "DDLog.h"
#import "UITool.h"
#import <UIKit/UIKit.h>

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation BLXMPPTool

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (XMPPStream *)xmppStream
{
    if (!_xmppStream) {
        _xmppStream = [[XMPPStream alloc] init];
        self.xmppStream.hostName = kXMPP_HOST;
        self.xmppStream.hostPort = kXMPP_PORT;
        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        _xmppReconnect = [[XMPPReconnect alloc] initWithDispatchQueue:dispatch_get_main_queue()];
        [self.xmppReconnect activate:self.xmppStream];
        self.xmppReconnect.autoReconnect = YES;
        
        _xmppRosterMemoryStorage = [[XMPPRosterMemoryStorage alloc] init];
        _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterMemoryStorage];
        [self.xmppRoster activate:self.xmppStream];
        [self.xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
        self.xmppRoster.autoFetchRoster = YES;
        self.xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
        
        _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        _xmppMessageArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)];
        [self.xmppMessageArchiving activate:self.xmppStream];
    }
    return _xmppStream;
}

#pragma mark - Public API
- (void)loginWithJID:(XMPPJID *)jid andPassword:(NSString *)pwd
{
    self.xmppStream.myJID = jid;
    self.myPassword = pwd;
    NSError *error;
    self.didRegistered = YES;
    [self.xmppStream connectWithTimeout:-1 error:&error];
}

- (void)registerWithJID:(XMPPJID *)jid andPassword:(NSString *)pwd
{
    self.xmppStream.myJID = jid;
    self.myPassword = pwd;
    NSError *error;
    self.didRegistered = NO;
    [self.xmppStream connectWithTimeout:-1 error:&error];
}

- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence];
    [presence addChild:[DDXMLNode elementWithName:@"status" stringValue:@"我现在好忙"]];
//    [presence addChild:[DDXMLNode elementWithName:@"show"   stringValue:@"dnd"]];
    [self.xmppStream sendElement:presence];
}

- (void)addFriend
{
    
}

#pragma mark - XMPPStreamDelegate
//socket connect success
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    NSError *error;
    [self.xmppStream authenticateWithPassword:self.myPassword error:&error];
    DDLogInfo(@"%@ --- %@",THIS_FILE, THIS_METHOD);
}

//stream connect success
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    if (!self.didRegistered) {
        [self.xmppStream registerWithPassword:self.myPassword error:nil];
    }else{
        [self.xmppStream authenticateWithPassword:self.myPassword error:nil];
    }
    DDLogInfo(@"%@ --- %@",THIS_FILE, THIS_METHOD);
}

//remove the contactor when someone delete
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    if ([presence.type isEqualToString:@"unsubscribe"]) {
        [self.xmppRoster removeUser:presence.from];
    }
}

//auth succeed
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    DDLogInfo(@"%@ --- %@",THIS_FILE, THIS_METHOD);
    [self goOnline];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:storyboard.instantiateInitialViewController];
}

//auth failed
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    DDLogInfo(@"%@ --- %@",THIS_FILE, THIS_METHOD);
//    if(error){
//        [UITool showWithTitle:@"Failed" message:@"Something wrong" defauleButtonTitle:nil cancelButtonTitle:@"OK"];
//        NSLog(@"error:%@",error);
//    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    DDLogCInfo(@"%@ --- %@",THIS_FILE, THIS_METHOD);
    
}


#pragma mark - Friend Delegate
/**
 * Sent when a presence subscription request is received.
 * That is, another user has added you to their roster,
 * and is requesting permission to receive presence broadcasts that you send.
 */
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    //[UITool showWithTitle:@"Request" message:@"Received a add friend request" defauleButtonTitle:@"Accept" cancelButtonTitle:@"Reject"];
    //TODO
    [self.xmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
}

/**
 * Sent when the initial roster has been populated into storage.
 **/
- (void)xmppRosterDidEndPopulating:(XMPPRoster *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kXMPP_ROSTER_CHANGE object:nil];
}

/**
 * When the roster changes, for any of the reasons listed below, this delegate method fires.
 * This method always fires after the more precise delegate methods listed below.
 **/
- (void)xmppRosterDidChange:(XMPPRosterMemoryStorage *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kXMPP_ROSTER_CHANGE object:nil];
}


@end
