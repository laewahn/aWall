//
//  AWViewController.h
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DepartureDownloaderDelegate.h"

@class DepartureDownloader;

@interface AWViewController : NSViewController<DepartureDownloaderDelegate>

@property(nonatomic, strong) DepartureDownloader* downloader;
@property(nonatomic, strong) NSTimer* departuresUpdateTimer;
@property(nonatomic, strong) NSDictionary* nextDeparture;

@end

