//
//  DepartureTimeFormatter.m
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "DepartureTimeFormatter.h"

@interface DepartureTimeFormatter() {
    NSDate* _referenceDate;
}
@end

@implementation DepartureTimeFormatter

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithReferenceDate:[NSDate date]];
}

- (instancetype)init
{
    return [self initWithReferenceDate:[NSDate date]];
}

- (instancetype)initWithReferenceDate:(NSDate *)referenceDate
{
    self = [super init];
    
    if (self) {
        _referenceDate = referenceDate;
    }
    
    return self;
}

- (NSString *)stringForObjectValue:(id)obj
{
    if (![obj isKindOfClass:[NSDate class]]) {
        return nil;
    }
    
    NSDate* theDate = (NSDate *)obj;
    NSTimeInterval remainingMinutes = floor([theDate timeIntervalSinceDate:_referenceDate] / 60);
    
    if (remainingMinutes == 0) {
        return @"less than one minute";
    } else if (remainingMinutes < 60) {
        NSString* unitString = (remainingMinutes <= 1) ? @"minute" : @"minutes";
        return [NSString stringWithFormat:@"%.0f %@", remainingMinutes, unitString];
    }
    
    NSDateFormatter* defaultFormatter = [[NSDateFormatter alloc] init];
    [defaultFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [defaultFormatter setDateStyle:NSDateFormatterNoStyle];
    
    return [defaultFormatter stringForObjectValue:theDate];
}

@end
