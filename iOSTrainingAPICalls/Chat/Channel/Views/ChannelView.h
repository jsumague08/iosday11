//
//  ChannelView.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Channel/Views/Cells/ChannelTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannelView : UIView

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITableView *channelTableView;

@end

NS_ASSUME_NONNULL_END
