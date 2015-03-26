//
//  UITool.h
//  Blablabla
//
//  Created by Wongzigii on 15/3/23.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITool : NSObject

+ (void)showWithTitle:(NSString *)title message:(NSString *)message defauleButtonTitle:(NSString *)defaultTitle cancelButtonTitle:(NSString *)cancelTitle;
@end
