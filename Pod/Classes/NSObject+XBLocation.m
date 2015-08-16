//
//  NSObject+XBLocation.m
//  Pods
//
//  Created by Binh Nguyen Xuan on 8/16/15.
//
//

#import "NSObject+XBLocation.h"

@implementation NSObject (XBLocation)

- (void)handleLocation:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:@"XBLocationDidChangeLocation" object:nil];
}

- (void)finishHandleLocation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XBLocationDidChangeLocation" object:nil];
}

@end
