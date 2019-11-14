//
//  Message.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../Channel/Models/DatabasePresentation.h"
#import <JSQMessage.h>
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface Message : JSQMessage <DatabasePresentation>
- (NSDictionary *)channelsDict;
@end

NS_ASSUME_NONNULL_END
