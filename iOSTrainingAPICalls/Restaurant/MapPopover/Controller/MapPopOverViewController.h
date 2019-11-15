//
//  MapPopOverViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../View/MapPopOver.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapPopOverViewController : UIViewController

@property (strong, nonatomic) MapPopOver *mapPopOverView;
@property (weak, nonatomic) IBOutlet MapPopOver *popover;

@end

NS_ASSUME_NONNULL_END
