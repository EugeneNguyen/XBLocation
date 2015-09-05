# XBLocation

[![CI Status](http://img.shields.io/travis/Eugene Nguyen/XBLocation.svg?style=flat)](https://travis-ci.org/Eugene Nguyen/XBLocation)
[![Version](https://img.shields.io/cocoapods/v/XBLocation.svg?style=flat)](http://cocoapods.org/pods/XBLocation)
[![License](https://img.shields.io/cocoapods/l/XBLocation.svg?style=flat)](http://cocoapods.org/pods/XBLocation)
[![Platform](https://img.shields.io/cocoapods/p/XBLocation.svg?style=flat)](http://cocoapods.org/pods/XBLocation)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How to use

1. Import XBLocation.h where you want to use location function

```obj-c
#import "XBLocation.h"
```

2. Start location service

```objc-c
[XBLocation registerLocation];
```

3. Add handle of location 

```obj-c
[self handleLocation:@selector(locationDidChange)];

// and

- (void)locationDidChange
{
    NSLog(@"%f %f", [XBLocation currentLocation].coordinate.latitude, [XBLocation currentLocation].coordinate.longitude);
}

// or you can use current location everywhere 
[XBLocation currentLocation];

```

## Requirements

## Installation

XBLocation is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XBLocation"
```

## Author

Eugene Nguyen, xuanbinh91@gmail.com

## License

XBLocation is available under the MIT license. See the LICENSE file for more info.
