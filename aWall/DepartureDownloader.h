//
//  DepartureDownloader.h
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DepartureDownloaderDelegate.h"

@interface DepartureDownloader : NSObject

- (void)downloadDeparturesForStopWithID:(NSString *)stopID;

@property(nonatomic, strong) NSURLSession* downloadSession;
@property(nonatomic, assign) id<DepartureDownloaderDelegate> delegate;

@end
