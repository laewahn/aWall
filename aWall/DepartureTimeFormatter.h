//
//  DepartureTimeFormatter.h
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartureTimeFormatter : NSFormatter

- (instancetype)initWithReferenceDate:(NSDate *)referenceDate;

@property(nonatomic, assign) BOOL capitalized;

@end
