//
//  AppDelegate.m
//  iSeag MenuIcon
//
//  Created by Dennis Lewandowski on 01/12/14.
//  Copyright (c) 2014 laewahn. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSStatusBar* systemStatusBar = [NSStatusBar systemStatusBar];
    [self setStatusItem:[systemStatusBar statusItemWithLength:NSSquareStatusItemLength]];
    
    NSImage* menuIconImage = [NSImage imageNamed:NSImageNameInfo];
    [menuIconImage setSize:NSMakeSize([systemStatusBar thickness] - 1, [systemStatusBar thickness] - 1)];
    
    [self.statusItem.button setImage:menuIconImage];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
