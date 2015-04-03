//
//  RegisterViewController.m
//  Blablabla
//
//  Created by Wongzigii on 15/3/21.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "RegisterViewController.h"
#import "XMPPFramework.h"
#import "BLXMPPTool.h"
#import "Constant.h"

@interface RegisterViewController ()<XMPPStreamDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UIButton    *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTextField.clipsToBounds = YES;
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.layer.borderWidth = 2.0f;
    self.usernameTextField.layer.borderColor = (__bridge CGColorRef)([UIColor lightGrayColor]);
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.registerButton.backgroundColor = [UIColor colorWithRed:78.0 / 255.0 green:204.0 / 255.0 blue:33.0 / 255.0 alpha:1.0];
    self.registerButton.clipsToBounds = YES;
    self.registerButton.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerUser:(id)sender {
    [[BLXMPPTool sharedInstance] registerWithJID:[XMPPJID jidWithUser:self.usernameTextField.text domain:kXMPP_DOMAIN resource:kRESOURCE] andPassword:self.passwordTextField.text];
}

- (IBAction)userLogin:(id)sender {
    [[BLXMPPTool sharedInstance] loginWithJID:[XMPPJID jidWithUser:self.usernameTextField.text domain:kXMPP_DOMAIN resource:kRESOURCE] andPassword:self.passwordTextField.text];
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"HAHAHAHA");
}

@end
