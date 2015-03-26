//
//  BLXMPPTool.h
//  Blablabla
//
//  Created by Wongzigii on 15/3/21.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

@interface BLXMPPTool : NSObject<XMPPStreamDelegate, XMPPRosterDelegate, XMPPRosterMemoryStorageDelegate>
@property (nonatomic, strong) XMPPStream    *xmppStream;
@property (nonatomic, strong) NSString      *myPassword;
@property (nonatomic, assign) BOOL          didRegistered;
@property (nonatomic, strong) XMPPAutoPing  *xmppAutoPing;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong) XMPPRoster    *xmppRoster;
@property (nonatomic, strong) XMPPRosterMemoryStorage *xmppRosterMemoryStorage;
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchiving;
@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
@property (nonatomic, strong) XMPPCoreDataStorage *xmppCoreDataStorage;
+ (instancetype)sharedInstance;

- (void)loginWithJID:(XMPPJID *)jid    andPassword:(NSString *)pwd;
- (void)registerWithJID:(XMPPJID *)jid andPassword:(NSString *)string;

@end
