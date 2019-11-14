//
//  MapPopOverViewController.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "MapPopOverViewController.h"

@interface MapPopOverViewController ()

@end

@implementation MapPopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapPopOverView = (MapPopOver *)[[[NSBundle mainBundle] loadNibNamed:@"MapPopOver" owner:self options:nil] objectAtIndex:0];
    self.mapPopOverView.frame = self.view.bounds;
    self.mapPopOverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.mapPopOverView];
}

@end
