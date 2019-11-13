//
//  ChannelViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../Chat/Channel/Views/ChannelView.h"
#import "../../Channel/Views/Cells/ChannelTableViewCell.h"
#import "../../Message/Controllers/MessageViewController.h"

@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface ChannelViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) ChannelView *channelView;
@property (strong, nonatomic) ChannelTableViewCell *channelTableViewCell;

//@property (strong, nonatomic)

@end

NS_ASSUME_NONNULL_END
