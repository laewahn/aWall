//
//  ViewController.m
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSArray* stubDepartures = @[
                                @{
                                    @"line": @"33",
                                    @"direction" : @"Aachen Fuchserde",
                                    @"departure" : @"In 20 min."
                                    },
                                @{
                                    @"line": @"12",
                                    @"direction" : @"Stolberg Bahnhof",
                                    @"departure" : @"In 22 min."
                                    }
                                ];
    
    [self setRepresentedObject:stubDepartures];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
