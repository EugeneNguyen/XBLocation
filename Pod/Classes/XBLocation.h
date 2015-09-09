//
//  XBLocation.h
//  Pods
//
//  Created by Binh Nguyen Xuan on 8/16/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NSObject+XBLocation.h"

@interface XBLocation : NSObject
{
    
}

+ (instancetype)sharedInstance;

+ (void)registerLocation;
+ (BOOL)hasLocationInformation;
+ (CLLocation *)currentLocation;
+ (CGFloat)distanceToLat:(CGFloat)lat lng:(CGFloat)lng;

@end