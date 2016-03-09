//
//  DepartureParserTests.m
//  aWall
//
//  Created by Dennis Lewandowski on 09/03/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DepartureParser.h"

@interface DepartureParserTests : XCTestCase

@end

@implementation DepartureParserTests

- (void)testParsingEmptyDepartureDataShouldReturnEmptyArray
{
    DepartureParser* testParser = [[DepartureParser alloc] init];
    NSData* emptyData = [NSData data];
    
    NSArray* parseResult = [testParser parseDepartureData:emptyData];
    
    XCTAssertEqual([parseResult count], 0);
}

@end
