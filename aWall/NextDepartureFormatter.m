//
//  NextDepartureFormatter.m
//  aWall
//
//  Created by Dennis Lewandowski on 30/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "NextDepartureFormatter.h"

#import "DepartureTimeFormatter.h"

@implementation NextDepartureFormatter

- (NSString *)stringForObjectValue:(id)obj
{
    if (![obj isKindOfClass:[NSDictionary class]]) {
            return nil;
    }
    
    NSDictionary* next = (NSDictionary *)obj;
    
    DepartureTimeFormatter* timeFormatter = [[DepartureTimeFormatter alloc] init];
    NSString* formattedDeparture = [timeFormatter stringForObjectValue:next[@"departure"]];
    NSString* formattedString = [NSString stringWithFormat:@"Next:\t%@ - %@\n\t\t\t\tin %@", next[@"line"], next[@"direction"], formattedDeparture];
    
    return formattedString;
}

@end
