//
//  AWViewController.m
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "AWViewController.h"


@implementation AWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimer* updateTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(loadAndUpdateDepartures) userInfo:nil repeats:YES];
    [self setDeparturesUpdateTimer:updateTimer];
    
    [self loadAndUpdateDepartures];
}

- (IBAction)refreshDepartureDataButtonPressed:(id)sender
{
    [self loadAndUpdateDepartures];
}

- (void)loadAndUpdateDepartures
{
    NSURLSession* departuresDownloadSession = [NSURLSession sharedSession];
    
    NSURL* departuresEndpointURL = [NSURL URLWithString:@"http://ivu.aseag.de/interfaces/ura/instant_V1?ReturnList=LineID,Latitude,Longitude,DestinationText,EstimatedTime&StopID=100625"];
    NSURLRequest* departuresInfoRequest = [NSURLRequest requestWithURL:departuresEndpointURL];
    
    NSURLSessionDataTask* departureDownloadTask = [departuresDownloadSession dataTaskWithRequest:departuresInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray* unsortedDepartures = [self parseDepartureData:data];
        
        NSSortDescriptor* sortByDepartureTime = [NSSortDescriptor sortDescriptorWithKey:@"departure" ascending:YES];
        NSArray* sortedDepartures = [unsortedDepartures sortedArrayUsingDescriptors:@[sortByDepartureTime]];
        
        NSPredicate* pendingDeparturesFilter = [NSPredicate predicateWithFormat:@"departure >= %@", [NSDate date]];
        NSArray* pendingDepartures = [sortedDepartures filteredArrayUsingPredicate:pendingDeparturesFilter];
        
        [self performSelectorOnMainThread:@selector(setRepresentedObject:) withObject:pendingDepartures waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(setNextDeparture:) withObject:[pendingDepartures firstObject] waitUntilDone:YES];
    }];
    
    [departureDownloadTask resume];
}

- (NSArray *)parseDepartureData:(NSData *)downloadData
{
    NSString* dataAsString = [[NSString alloc] initWithData:downloadData encoding:NSUTF8StringEncoding];
    
    NSArray* dataInLines = [dataAsString componentsSeparatedByString:@"\r"];
    NSArray* departureStrings = [dataInLines subarrayWithRange:NSMakeRange(1, [dataInLines count] - 1)];
    
    NSMutableArray* parsedDepartures = [NSMutableArray arrayWithCapacity:[departureStrings count]];
    for (NSString* departureString in departureStrings) {
        NSString* trimmedDepartureString = [departureString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSDictionary* parsedDeparture = [self parseDepartureString:trimmedDepartureString];
        [parsedDepartures addObject:parsedDeparture];
    }
    
    return parsedDepartures;
}

- (NSDictionary *)parseDepartureString:(NSString *)departureString
{
    NSMutableDictionary* departure = [NSMutableDictionary dictionary];

    NSError* jsonError;
    NSArray* departureComponents = [NSJSONSerialization JSONObjectWithData:[departureString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
    
    [departure setObject:departureComponents[3] forKey:@"line"];
    [departure setObject:departureComponents[4] forKey:@"direction"];

    
    NSNumber* departureTimeInPosixTime = departureComponents[5];
    NSDate* departureDate = [NSDate dateWithTimeIntervalSince1970:[departureTimeInPosixTime longValue]/1000];

    [departure setObject:departureDate forKey:@"departure"];
    
    return departure;
}

@end
