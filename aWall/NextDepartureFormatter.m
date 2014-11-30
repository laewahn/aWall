//
//  NextDepartureFormatter.m
//  aWall
//
//  Created by Dennis Lewandowski on 30/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "NextDepartureFormatter.h"

#import "DepartureTimeFormatter.h"

@interface NextDepartureFormatter () {
    NSFormatter* _departureFormatter;
}
@end

@implementation NextDepartureFormatter

- (NSString *)stringForObjectValue:(id)obj
{
    if (![obj isKindOfClass:[NSDictionary class]]) {
            return nil;
    }
    
    NSDictionary* next = (NSDictionary *)obj;
    
    NSString* formattedDeparture = [self.departureFormatter stringForObjectValue:next[@"departure"]];
    NSString* formattedString = [NSString stringWithFormat:@"Next:\t%@ - %@\n\t\t\t\tin %@", next[@"line"], next[@"direction"], formattedDeparture];
    
    return formattedString;
}

- (NSFormatter *)departureFormatter
{
    if (_departureFormatter == nil) {
        _departureFormatter = [[DepartureTimeFormatter alloc] init];
    }
    
    return _departureFormatter;
}

@end
