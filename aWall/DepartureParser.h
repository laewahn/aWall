//
//  DepartureParser.h
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartureParser : NSObject

- (NSArray *)parseDepartureData:(NSData *)theData;

@end
