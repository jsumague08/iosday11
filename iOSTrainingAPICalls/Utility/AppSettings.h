//
//  AppSettings.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#ifndef AppSettings_h
#define AppSettings_h
@import FirebaseAuth;

@interface AppSettings : NSObject

+(instancetype)shared;
- (void)setUsername:(NSString *)username;
- (NSString *)getUsername;

@end
#endif /* AppSettings_h */
