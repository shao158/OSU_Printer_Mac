//
//  AppDelegate.m
//  OSU_Printer
//
//  Created by Jinjin Shao on 8/2/15.
//  Copyright (c) 2015 Shao158. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
    
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self.window setFrame:NSMakeRect(500, 300, 600, 450) display:YES];
    [self.window setMaxSize:NSSizeFromCGSize(CGSizeMake(600, 450))];
    [self.window setMinSize:NSSizeFromCGSize(CGSizeMake(600, 450))];
    [self.window setBackgroundColor:[NSColor whiteColor]];
    
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    [NSApp setDelegate:self.masterViewController];
    
    [self.window.contentView addSubview: self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
