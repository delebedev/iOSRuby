//
//  AppDelegate.m
//  iOSRuby
//
//  Created by Denis Lebedev on 24.3.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	
	self.window.rootViewController = [[MainViewController alloc] init];
    [self.window makeKeyAndVisible];
	
	return YES;
}

@end
