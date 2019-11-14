//
//  MessageViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessagesViewController.h>
@import FirebaseFirestore;
@import FirebaseAuth;
#import "../../Channel/Models/Channel.h"
#import "../../Message/Models/Message.h"
#import "../../../Utility/AppSettings.h"
#import "JSQMessagesAvatarImageFactory.h"
#import "JSQMessagesBubbleImageFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : JSQMessagesViewController <JSQMessagesInputToolbarDelegate,JSQMessagesCollectionViewDataSource>

+ (instancetype)initWithChannel:(Channel *)channel withUser:(FIRUser *)user;

@end

NS_ASSUME_NONNULL_END
