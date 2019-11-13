//
//  Channel.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "Channel.h"

@implementation Channel

+ (instancetype)initWithChannelName:(NSString *)channelName {
    Channel *channel = [[Channel alloc] init];
    channel.channelName = channelName;
    return channel;
}

+ (instancetype)initWithDocument:(FIRQueryDocumentSnapshot *)document {
    NSDictionary *data = document.data;
    NSString *name = data[@"name"];
    if (name == nil) {
        return nil;
    }
    Channel *channel = [Channel initWithChannelName:name];
    channel.channelId = data[@"id"];
    return channel;
}

- (NSDictionary *)presentation {
    NSDictionary *value;
    value = @{@"name": self.channelName};
    return value;
}

@end
