//
//  DepartureTimeFormatterTests.m
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "DepartureTimeFormatter.h"

@interface DepartureTimeFormatterTests : XCTestCase {
    DepartureTimeFormatter* testFormatter;
    NSDate* referenceDate;
}
@end

@implementation DepartureTimeFormatterTests

- (void)setUp
{
    referenceDate = [NSDate date];
    testFormatter = [[DepartureTimeFormatter alloc] initWithReferenceDate:referenceDate];
}

- (void)testItDoesNotFormatWhatIsNotADate
{
    testFormatter = [[DepartureTimeFormatter alloc] init];
    
    NSString* formattedDate = [testFormatter stringForObjectValue:@"This is not a date."];

    XCTAssertNil(formattedDate);
}

- (void)testItReturnsTheTimeWhenDepartureIsInMoreThanOneHour
{
    NSDate* oneHourLater = [referenceDate dateByAddingTimeInterval:(NSTimeInterval)60*60];
 
    NSDateFormatter* defaultFormatter = [[NSDateFormatter alloc] init];
    [defaultFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [defaultFormatter setDateStyle:NSDateFormatterNoStyle];
    
    XCTAssertEqualObjects([testFormatter stringForObjectValue:oneHourLater], [defaultFormatter stringForObjectValue:oneHourLater]);
}

- (void)testItReturnsInFiveMinutesWhenDepartureIsInFiveMinutes
{
    NSDate* fiveMinutesLater = [referenceDate dateByAddingTimeInterval:(NSTimeInterval)60*5];
    
    XCTAssertEqualObjects([testFormatter stringForObjectValue:fiveMinutesLater], @"5 minutes");
}

- (void)testItReturnsInTwoMinutesWhenDepartureIsInTwoMinutes
{
    NSDate* twoMinutesLater = [referenceDate dateByAddingTimeInterval:(NSTimeInterval)60*2];
    
    XCTAssertEqualObjects([testFormatter stringForObjectValue:twoMinutesLater], @"2 minutes");
}

@end
