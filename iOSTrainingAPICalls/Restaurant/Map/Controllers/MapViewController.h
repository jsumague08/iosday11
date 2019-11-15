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
#import "../../MapPopover/View/MapPopOver.h"
#import "../../MapPopover/Controller/MapPopOverViewController.h"
#import "../../../Restaurant/RestaurantDetails/Controllers/RestaurantDetailsViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSMarkerLayer *marker;

@property (strong, nonatomic) MapView *mapView;
@property (strong, nonatomic) NSMutableArray *arrayOfRestaurants;
@property (strong, nonatomic) MapPopOver *popOver;


@end

NS_ASSUME_NONNULL_END
