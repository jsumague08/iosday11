//
//  RestaurantDetailsViewController.h
//  iOSTrainingAPICalls
//
//  Created by OPS on 11/9/19.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Views/RestaurantDetailsView.h"
#import "../../Restaurants/Models/Restaurants.h"
#import <GoogleMaps/GoogleMaps.h>


NS_ASSUME_NONNULL_BEGIN

@interface RestaurantDetailsViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSMarkerLayer *marker;

@property (strong, nonatomic) RestaurantDetailsView *restaurantsDetailsView;
@property (strong, readwrite) Restaurants *restaurant;

@end

NS_ASSUME_NONNULL_END
