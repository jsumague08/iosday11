//
//  MapViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 11/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "../View/MapView.h"
#import "../../Restaurants/Models/Restaurants.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MapView *mapView;
@property (strong, nonatomic) NSMutableArray *arrayOfRestaurants;
- (IBAction)backNavigationButtonPressed:(id)sender;


@end

NS_ASSUME_NONNULL_END
