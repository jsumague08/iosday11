//
//  MapViewController.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 11/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "MapViewController.h"
#import "../../Restaurants/Models/Restaurants.h"

const float zoom = 15.0f;

@interface MapViewController ()

@end
//my copy
@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = (MapView *)[[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil] objectAtIndex:0];
    
    self.mapView.frame = self.view.bounds;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.mapView];
    
    [self checkLocationAccess];
    [self setupMap];
    [self startLocationService];
}

- (void)startLocationService {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
}

- (void)checkLocationAccess {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    switch (status) {
        case kCLAuthorizationStatusDenied:
            [_locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            break;
        case kCLAuthorizationStatusNotDetermined:
            [_locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"In use");
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Auth Always");
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Not Determined");
            break;
    }
}

- (void)setupMap {
    [self setUpMarkersWithRestaurantData];
}


- (void)setUpMarkersWithRestaurantData {
    BOOL isFirstLocation = YES;
    for (Restaurants *restaurant in self.arrayOfRestaurants) {
        CLLocationCoordinate2D locationCoordinates;
        locationCoordinates.latitude = restaurant.latitude;
        locationCoordinates.longitude = restaurant.longitude;
        
        if (isFirstLocation) {
            [self setCameraForFirstRestaurant:restaurant.latitude withLongitude:restaurant.longitude];
            isFirstLocation = NO;
        }
        
        [self prepareMarkersForPlacement:locationCoordinates withRestaurantName:restaurant.restaurantName];
    }
}

- (void)prepareMarkersForPlacement:(CLLocationCoordinate2D)location withRestaurantName:(NSString *)restaurantName {
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = location;
    marker.title = restaurantName;
    marker.map = _mapView;
}

- (void)setCameraForFirstRestaurant:(double)latitude withLongitude:(double)longitude {
    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:zoom];
    _mapView.camera = camera;
    _mapView.myLocationEnabled = YES;
    
    [self centerToLocation:firstLocation];
}

- (void)centerToLocation:(CLLocation *)location {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:zoom];
    _mapView.camera = camera;
}

- (IBAction)backNavigationButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
