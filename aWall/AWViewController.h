//
//  AWViewController.h
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "IVUDepartureDownloader.h"

@interface AWViewController : NSViewController<IVUDepartureDownloaderDelegate>

@property(nonatomic, strong) IVUDepartureDownloader* downloader;
@property(nonatomic, strong) NSTimer* departuresUpdateTimer;
@property(nonatomic, strong) NSDictionary* nextDeparture;

@end

