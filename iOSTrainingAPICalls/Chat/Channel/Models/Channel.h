//
//  Channel.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabasePresentation.h"
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface Channel : NSObject <DatabasePresentation>

@property (copy, readwrite) NSString *channelName;
@property (copy, readwrite) NSString *channelId;

+ (instancetype)initWithChannelName:(NSString *)channelName;
+ (instancetype)initWithDocument:(FIRQueryDocumentSnapshot *) document;
@end

NS_ASSUME_NONNULL_END
