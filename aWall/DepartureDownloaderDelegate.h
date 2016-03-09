//
//  DepartureDownloaderDelegate.h
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

@class DepartureDownloader;

@protocol DepartureDownloaderDelegate <NSObject>
- (void)downloader:(DepartureDownloader *)downloader finishedLoadingDeparturesData:(NSData *)data;
@end
