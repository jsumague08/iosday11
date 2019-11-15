
//
//  LoginViewController.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "LoginViewController.h"
#import "../../../Utility/AppSettings.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView = (LoginView *)[[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self  options:nil]objectAtIndex:0];
    self.loginView.frame = self.view.bounds;
    self.loginView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewContentModeCenter;
    self.loginView.containerView.layer.cornerRadius = 50;
    self.loginView.containerView.layer.masksToBounds = YES;
    self.loginView.shadowView.layer.shadowOffset = CGSizeMake(3,3);
    self.loginView.shadowView.layer.shadowOpacity = 0.3f;
    
    
    self.loginView.loginViewDelegate = self;
    [self.view addSubview:self.loginView];
}

- (void) didTapProceedButton {
    if ([self.loginView.userNameTextField.text isEqualToString:@""]) {
        return;
    }
    
    [AppSettings.shared setUsername:self.loginView.userNameTextField.text];
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error Signing In");
            return;
        }
        self.loginView.userNameTextField.text = @"";
        [self performSegueWithIdentifier:@"LoginToChannelSegueIdentifier" sender:[authResult user]];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoginToChannelSegueIdentifier"]) {
        ChannelViewController *channelViewController = [segue destinationViewController];
        channelViewController.user = sender;
    }
}

@end
