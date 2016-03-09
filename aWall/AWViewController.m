//
//  AWViewController.m
//  aWall
//
//  Created by Dennis Lewandowski on 28/11/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "AWViewController.h"

#import "DepartureDownloader.h"
#import "DepartureParser.h"

@implementation AWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimer* updateTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(loadAndUpdateDepartures) userInfo:nil repeats:YES];
    [self setDeparturesUpdateTimer:updateTimer];
    
    [self loadAndUpdateDepartures];
}

- (void)loadAndUpdateDepartures
{
    [self.downloader downloadDeparturesForStopWithID:@"100625"];
}


# pragma mark -
# pragma mark Property implementation

- (DepartureDownloader *)downloader
{
    if (_downloader == nil) {
        DepartureDownloader* downloader = [[DepartureDownloader alloc] init];
        [downloader setDelegate:self];
        
        _downloader = downloader;
    }
    
    return _downloader;
}


# pragma mark -
# pragma mark DepartureDownloaderDelegate implementation

- (void)downloader:(DepartureDownloader *)downloader finishedLoadingDeparturesData:(NSData *)data
{
    DepartureParser* parser = [[DepartureParser alloc] init];
    NSArray* unsortedDepartures = [parser parseDepartureData:data];
    
    if ([unsortedDepartures count] == 0) {
        return;
    }
    
    NSSortDescriptor* sortByDepartureTime = [NSSortDescriptor sortDescriptorWithKey:@"departure" ascending:YES];
    NSArray* sortedDepartures = [unsortedDepartures sortedArrayUsingDescriptors:@[sortByDepartureTime]];
    
    NSPredicate* pendingDeparturesFilter = [NSPredicate predicateWithFormat:@"departure >= %@", [NSDate date]];
    NSArray* pendingDepartures = [sortedDepartures filteredArrayUsingPredicate:pendingDeparturesFilter];
    
    NSDictionary* nextDeparture = [pendingDepartures firstObject];
    NSArray* departuresForList = [pendingDepartures subarrayWithRange:NSMakeRange(1, [pendingDepartures count] -1)];
    
    [self performSelectorOnMainThread:@selector(setRepresentedObject:) withObject:departuresForList waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(setNextDeparture:) withObject:nextDeparture waitUntilDone:YES];
}


# pragma mark -
# pragma mark Data parsing

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
