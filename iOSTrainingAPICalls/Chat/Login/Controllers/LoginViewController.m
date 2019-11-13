
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
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        [AppSettings.shared setUsername:self.loginView.userNameTextField.text];
        [self performSegueWithIdentifier:@"LoginToChannelSegueIdentifier" sender:self];
    }];
}

@end
