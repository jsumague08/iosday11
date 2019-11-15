//
//  RestaurantDetailsView.h
//  iOSTrainingAPICalls
//
//  Created by OPS on 11/9/19.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantDetailsView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImageView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCuisineLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantTiming;
@property (weak, nonatomic) IBOutlet UILabel *averageCostForTwoLabel;
@property (weak, nonatomic) IBOutlet UIView *titleAndRatingView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIView *miniMapView;

//@property (weak, nonatomic) IBOutlet GMSMapView *map;


@end

NS_ASSUME_NONNULL_END
