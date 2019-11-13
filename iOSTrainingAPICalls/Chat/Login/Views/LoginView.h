//
//  LoginView.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

@required
- (void)didTapProceedButton;

@end

@interface LoginView : UIView
@property (strong) id<LoginViewDelegate> loginViewDelegate;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@end

NS_ASSUME_NONNULL_END
