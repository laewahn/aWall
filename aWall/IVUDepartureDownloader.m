//
//  IVUDepartureDownloader.m
//  aWall
//
//  Created by Dennis Lewandowski on 09/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "IVUDepartureDownloader.h"

NSString * const kDeparturesEndpointURLFormatString = @"http://ivu.aseag.de/interfaces/ura/instant_V1?ReturnList=LineID,Latitude,Longitude,DestinationText,EstimatedTime&StopID=%@";

@implementation IVUDepartureDownloader

- (void)downloadDeparturesForStopWithID:(NSString *)stopID
{
    NSURL* departuresEndpointURL = [NSURL URLWithString:[NSString stringWithFormat:kDeparturesEndpointURLFormatString, stopID]];
    NSURLRequest* departuresInfoRequest = [NSURLRequest requestWithURL:departuresEndpointURL];
    
    NSURLSessionDataTask* departureDownloadTask = [self.downloadSession dataTaskWithRequest:departuresInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self.delegate downloader:self finishedLoadingDeparturesData:data];
    }];
    
    [departureDownloadTask resume];
}

- (NSURLSession *)downloadSession
{
    if (_downloadSession == nil) {
        _downloadSession = [NSURLSession sharedSession];
    }
    
    return _downloadSession;
}

@end
