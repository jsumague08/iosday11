//
//  RestaurantDetailsViewController.m
//  iOSTrainingAPICalls
//
//  Created by OPS on 11/9/19.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "RestaurantDetailsViewController.h"



@interface RestaurantDetailsViewController ()

@end

@implementation RestaurantDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantsDetailsView = (RestaurantDetailsView *)[[[NSBundle mainBundle] loadNibNamed:@"RestaurantDetailsView" owner:self options:nil] objectAtIndex:0];
    self.restaurantsDetailsView.frame = self.view.bounds;
    self.restaurantsDetailsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self setupUIElementFormats];
    
    [self getRestaurant];
    [self.view addSubview:self.restaurantsDetailsView];
    self.navigationItem.title = @"Restaurant";
    [self checkLocationAccess];
    [self setupMap];
    [self startLocationService];
}

- (void)setupUIElementFormats {
    self.restaurantsDetailsView.titleAndRatingView.layer.borderWidth = 0.5;
    self.restaurantsDetailsView.distanceLabel.text = [self calculateDistanceFromCurrentLocation];
    self.restaurantsDetailsView.mapContainerView.layer.shadowOffset = CGSizeMake(3, 3);
    self.restaurantsDetailsView.mapContainerView.layer.shadowOpacity = 0.3f;
}

- (void)getRestaurant {
    self.restaurantsDetailsView.restaurantNameLabel.text = self.restaurant.restaurantName;
    self.restaurantsDetailsView.restaurantCuisineLabel.text = self.restaurant.restaurantCuisines;
    self.restaurantsDetailsView.restaurantRatingLabel.text = [NSString stringWithFormat:@"%.01f", self.restaurant.restaurantUserRating];
    self.restaurantsDetailsView.restaurantAddressLabel.text = self.restaurant.restaurantLocation;
    self.restaurantsDetailsView.restaurantTiming.text = self.restaurant.restaurantTiming;
    self.restaurantsDetailsView.averageCostForTwoLabel.text = [NSString stringWithFormat:@"%.02f", self.restaurant.restaurantAverageCostForTwo];
    
    NSArray  *data = [self.restaurant.restaurantThumb componentsSeparatedByString:@"?"];
    for(NSString* str in data)
    {
        if([NSURLConnection canHandleRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]]) {
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
            self.restaurantsDetailsView.restaurantImageView.image = [UIImage imageWithData: imageData];
            NSLog(@"%@",[[NSString alloc ] initWithFormat:@"Found a URL: %@",str]);
        }
    }
}

- (void)startLocationService {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
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

- (void)prepareMarkersForPlacement:(CLLocationCoordinate2D)location withRestaurantName:(NSString *)restaurantName {
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = location;
    marker.title = restaurantName;
    marker.map = self.restaurantsDetailsView.miniMapView;
    [self.restaurantsDetailsView.miniMapView setSelectedMarker:marker];
}

- (void)setCameraForFirstRestaurant:(double)latitude withLongitude:(double)longitude {
    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    float zoom = 17.0f;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:zoom];
    self.restaurantsDetailsView.miniMapView.camera = camera;
    self.restaurantsDetailsView.miniMapView.myLocationEnabled = YES;
    
    [self centerToLocation:firstLocation];
}

- (void)centerToLocation:(CLLocation *)location {
    float zoom = 17.0f;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:zoom];
    self.restaurantsDetailsView.miniMapView.camera = camera;
}

- (void)setUpMarkersWithRestaurantData {
    BOOL isFirstLocation = YES;
        CLLocationCoordinate2D locationCoordinates;
        locationCoordinates.latitude = self.restaurant.latitude;
        locationCoordinates.longitude = self.restaurant.longitude;
            [self setCameraForFirstRestaurant:self.restaurant.latitude withLongitude:self.restaurant.longitude];
        [self prepareMarkersForPlacement:locationCoordinates withRestaurantName:self.restaurant.restaurantName];
    
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

- (void)setupMap {
    [self setUpMarkersWithRestaurantData];
}

- (NSString *)calculateDistanceFromCurrentLocation {
    CLLocation *restaurantLocation = [[CLLocation alloc] initWithLatitude:self.restaurant.latitude longitude:self.restaurant.longitude];
    
    CLLocation *simulatedCurrentLocation = [[CLLocation alloc] initWithLatitude:14.219866 longitude:121.037037];
    
    CLLocationDistance distance = [restaurantLocation distanceFromLocation:simulatedCurrentLocation] / 1000;
    
    NSString *distanceInString = [NSString stringWithFormat:@"%.02fKM", distance];
    
    return distanceInString;
}

//- (void)setUpMarkersWithRestaurantData {
//    BOOL isFirstLocation = YES;
//        CLLocationCoordinate2D locationCoordinates;
//        locationCoordinates.latitude = restaurant.latitude;
//        locationCoordinates.longitude = restaurant.longitude;
//        if (isFirstLocation) {
//            [self setCameraForFirstRestaurant:restaurant.latitude withLongitude:restaurant.longitude];
//            isFirstLocation = NO;
//        }
//        [self prepareMarkersForPlacement:locationCoordinates withRestaurantName:restaurant.restaurantName];
//    }
//}
@end
