//
//  ChatViewController.h
//  Blablabla
//
//  Created by Wongzigii on 15/3/24.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"

@interface ChatViewController : UIViewController
@property (nonatomic, strong) XMPPJID *contactJID;
@property (nonatomic, strong) NSMutableArray *historyArray;
@end
