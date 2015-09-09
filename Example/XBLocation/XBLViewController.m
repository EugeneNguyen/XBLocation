//
//  XBLViewController.m
//  XBLocation
//
//  Created by Eugene Nguyen on 08/16/2015.
//  Copyright (c) 2015 Eugene Nguyen. All rights reserved.
//

#import "XBLViewController.h"
#import "XBLocation.h"

@interface XBLViewController ()

@end

@implementation XBLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [XBLocation registerLocation];
    
    [self handleLocation:@selector(locationDidChange)];
}

- (void)locationDidChange
{
    NSLog(@"%f %f", [XBLocation currentLocation].coordinate.latitude, [XBLocation currentLocation].coordinate.longitude);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
