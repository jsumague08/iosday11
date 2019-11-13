//
//  LoginViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Login/Views/LoginView.h"
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN


@interface LoginViewController : UIViewController <LoginViewDelegate>

@property (strong, nonatomic) LoginView *loginView;

@end

NS_ASSUME_NONNULL_END
