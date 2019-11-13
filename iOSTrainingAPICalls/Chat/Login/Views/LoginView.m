//
//  LoginView.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (IBAction)didTapProceedButton:(id)sender {
    if (self.loginViewDelegate && [self.loginViewDelegate respondsToSelector:@selector(didTapProceedButton)]) {
        [self.loginViewDelegate didTapProceedButton];
    }
}
@end
