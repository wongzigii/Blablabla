//
//  UITool.m
//  Blablabla
//
//  Created by Wongzigii on 15/3/23.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "UITool.h"
#import <UIKit/UIKit.h>

@implementation UITool
+ (void)showWithTitle:(NSString *)title message:(NSString *)message defauleButtonTitle:(NSString *)defaultTitle cancelButtonTitle:(NSString *)cancelTitle
{
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"Cancel");
                                                   }];
    [alertViewController addAction:cancel];
    
    if(defaultTitle){
        UIAlertAction *ok = [UIAlertAction actionWithTitle:defaultTitle
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"OK");
                                                   }];
        [alertViewController addAction:ok];
    }
    UIViewController *topmost = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (!alertViewController.isBeingPresented) {
        [topmost presentViewController:alertViewController animated:YES completion:^{
            
        }];
    }
}

@end
