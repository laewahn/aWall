//
//  IVUDepartureDownloaderDelegate.h
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

@class IVUDepartureDownloader;

@protocol IVUDepartureDownloaderDelegate <NSObject>
- (void)downloader:(IVUDepartureDownloader *)downloader finishedLoadingDeparturesData:(NSData *)data;
@end
