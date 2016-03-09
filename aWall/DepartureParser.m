//
//  DepartureParser.m
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "DepartureParser.h"

@implementation DepartureParser

- (NSArray *)parseDepartureData:(NSData *)downloadData
{
    NSString* dataAsString = [[NSString alloc] initWithData:downloadData encoding:NSUTF8StringEncoding];
    
    NSArray* dataInLines = [dataAsString componentsSeparatedByString:@"\r"];
    NSArray* departureStrings = [dataInLines subarrayWithRange:NSMakeRange(1, [dataInLines count] - 1)];
    
    NSMutableArray* parsedDepartures = [NSMutableArray arrayWithCapacity:[departureStrings count]];
    for (NSString* departureString in departureStrings) {
        NSString* trimmedDepartureString = [departureString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSDictionary* parsedDeparture = [self parseDepartureString:trimmedDepartureString];
        [parsedDepartures addObject:parsedDeparture];
    }
    
    return parsedDepartures;
}

- (NSDictionary *)parseDepartureString:(NSString *)departureString
{
    NSMutableDictionary* departure = [NSMutableDictionary dictionary];
    
    NSError* jsonError;
    NSArray* departureComponents = [NSJSONSerialization JSONObjectWithData:[departureString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
    
    [departure setObject:departureComponents[3] forKey:@"line"];
    [departure setObject:departureComponents[4] forKey:@"direction"];
    
    
    NSNumber* departureTimeInPosixTime = departureComponents[5];
    NSDate* departureDate = [NSDate dateWithTimeIntervalSince1970:[departureTimeInPosixTime longValue]/1000];
    
    [departure setObject:departureDate forKey:@"departure"];
    
    return departure;
}

@end
