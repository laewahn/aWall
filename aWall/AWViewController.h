//
//  AWViewController.h
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AWViewController : NSViewController

@property(nonatomic, strong) NSTimer* departuresUpdateTimer;
@property(nonatomic, strong) NSDictionary* nextDeparture;

@end

