//
// Created by Terry Lewis II on 2/8/14.
// Copyright (c) 2014 Terry Lewis. All rights reserved.
//

#import "JMCAnnotation.h"


@interface JMCAnnotation ()

@end

@implementation JMCAnnotation
@synthesize title =_title;

- (instancetype)initWithTitle:(NSString*)title andLocation:(CLLocation *)location; {
    self = [super init];

    if(!self) {
        return nil;
    }
    _title = title;
    _location = location;

    return self;
}

- (CLLocationCoordinate2D)coordinate {
    return self.location.coordinate;
}

-(NSString *)title{
    return _title;
}


@end