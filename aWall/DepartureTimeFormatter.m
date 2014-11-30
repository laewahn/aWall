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
    NSFormatter* _defaultFormatter;
}
@end

@implementation DepartureTimeFormatter

- (instancetype)initWithReferenceDate:(NSDate *)referenceDate
{
    self = [super init];
    
    if (self) {
        _referenceDate = referenceDate;
    }
    
    return self;
}

- (NSDate *)referenceDate
{
    return _referenceDate ?: [NSDate date];
}

- (NSFormatter *)defaultFormatter
{
    if (_defaultFormatter == nil) {
        
        NSDateFormatter* defaultFormatter = [[NSDateFormatter alloc] init];
        [defaultFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [defaultFormatter setDateStyle:NSDateFormatterNoStyle];

        _defaultFormatter = defaultFormatter;
    }
    
    return _defaultFormatter;
}

- (NSString *)stringForObjectValue:(id)obj
{
    if (![obj isKindOfClass:[NSDate class]]) {
        return nil;
    }
    
    NSDate* theDate = (NSDate *)obj;
    
    NSTimeInterval remainingMinutes = floor([theDate timeIntervalSinceDate:[self referenceDate]] / 60);
    
    if (remainingMinutes == 0) {
        return [self capitalized] ? @"Less than one minute" : @"less than one minute";
    } else if (remainingMinutes < 60) {
        NSString* unitString = (remainingMinutes <= 1) ? @"minute" : @"minutes";
        return [NSString stringWithFormat:@"%.0f %@", remainingMinutes, unitString];
    }
    
    return [self.defaultFormatter stringForObjectValue:theDate];
}

@end
