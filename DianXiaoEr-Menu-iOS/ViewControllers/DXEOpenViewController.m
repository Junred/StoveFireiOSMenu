//
//  DXEOpenViewController.m
//  DianXiaoEr-Menu-iOS
//
//  Created by Joe Shang on 8/12/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "DXEOpenViewController.h"
#import "DXEMainViewController.h"
#import "DXELoginView.h"
#import "CRModal.h"

@interface DXEOpenViewController ()

@property (nonatomic, strong) DXELoginView *loginView;

@end

@implementation DXEOpenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View Related

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Target-Action

- (IBAction)onEnterButtonClicked:(id)sender
{
    NSString *nibName = NSStringFromClass([DXELoginView class]);
    self.loginView = [[[NSBundle mainBundle] loadNibNamed:nibName
                                                    owner:self
                                                  options:nil] firstObject];
    self.loginView.controller = self;
    self.loginView.userNamePlaceholder = @"工号";
    self.loginView.loginFailedMessage.text = @"工号或密码输入错误，请重新输入！";
    [CRModal showModalView:self.loginView
               coverOption:CRModalOptionCoverDark
       tapOutsideToDismiss:NO
                  animated:YES
                completion:^{
                    [UIView animateWithDuration:0.3
                                     animations:^{
                                         self.view.alpha = 0.0;
                                     }
                                     completion:^(BOOL finished){
                                         [self willMoveToParentViewController:nil];
                                         [self.view removeFromSuperview];
                                         [self removeFromParentViewController];
                                     }];
                }];
}

- (IBAction)onChoosingTableButtonClicked:(id)sender
{
    
}

- (void)onLoginButtonClickedInLoginView:(DXELoginView *)loginView
{
    [CRModal dismiss];
}

@end
