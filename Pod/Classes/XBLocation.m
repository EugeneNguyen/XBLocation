//
//  XBLocation.m
//  Pods
//
//  Created by Binh Nguyen Xuan on 8/16/15.
//
//

#import "XBLocation.h"

static XBLocation *__sharedXBLocation = nil;

@interface XBLocation ()
{
    CLLocationManager * locationManager;
    CLLocation * _currentLocation;
}

@property (nonatomic, assign) BOOL hasLocationInformation;

- (void)registerLocation;

@end

@implementation XBLocation
@synthesize hasLocationInformation = _hasLocationInformation;

+ (instancetype)sharedInstance
{
    if (!__sharedXBLocation)
    {
        __sharedXBLocation = [[XBLocation alloc] init];
    }
    return __sharedXBLocation;
}

+ (void)registerLocation
{
    [[XBLocation sharedInstance] registerLocation];
}

- (void)registerLocation
{
    if (![self checkSetting])
    {
        return;
    }
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = (id <CLLocationManagerDelegate> )self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeFitness;
    
    locationManager.distanceFilter = 10;
    
    [self requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

- (BOOL)checkSetting
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *information = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!information[@"NSLocationAlwaysUsageDescription"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please add NSLocationAlwaysUsageDescription in your Info.plist" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse | status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestAlwaysAuthorization];
        [locationManager startUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusAuthorizedAlways)
    {
        [locationManager requestAlwaysAuthorization];
        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = [locations lastObject];
    _hasLocationInformation = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XBLocationDidChangeLocation" object:nil];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

+ (CLLocation *)currentLocation
{
    return [[XBLocation sharedInstance] currentLocation];
}

+ (BOOL)hasLocationInformation
{
    return [[XBLocation sharedInstance] hasLocationInformation];
}

- (CLLocation *)currentLocation
{
    return _currentLocation;
}

+ (CGFloat)distanceToLat:(CGFloat)lat lng:(CGFloat)lng
{
    if (![XBLocation currentLocation])
    {
        return  -1;
    }
    CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    return [[XBLocation currentLocation] distanceFromLocation:location];
}


@end
