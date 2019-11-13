//
//  MessageViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessagesViewController.h>
@import FirebaseFirestore;
#import "../../Channel/Models/Channel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : JSQMessagesViewController

+ (instancetype)initWithChannel:(Channel *)channel;

@end

NS_ASSUME_NONNULL_END
