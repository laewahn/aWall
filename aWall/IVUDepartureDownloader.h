//
//  IVUDepartureDownloader.h
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IVUDepartureDownloader;

@protocol IVUDepartureDownloaderDelegate <NSObject>
- (void)downloader:(IVUDepartureDownloader *)downloader finishedLoadingDeparturesData:(NSData *)data;
@end


@interface IVUDepartureDownloader : NSObject

- (void)downloadDeparturesForStopWithID:(NSString *)stopID;

@property(nonatomic, strong) NSURLSession* downloadSession;
@property(nonatomic, assign) id<IVUDepartureDownloaderDelegate> delegate;

@end
