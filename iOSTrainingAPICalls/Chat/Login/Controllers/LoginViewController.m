
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
    self.loginView.loginViewDelegate = self;
    [self.view addSubview:self.loginView];
}

- (void) didTapProceedButton {
    [AppSettings.shared setUsername:self.loginView.userNameTextField.text];
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error Signing In");
            return;
        }
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
