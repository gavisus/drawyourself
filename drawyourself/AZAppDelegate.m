//
//  AZAppDelegate.m
//  drawyourself
//
//  Created by Jung Kim on 12. 10. 8..
//  Copyright (c) 2012년 AuroraPlanet. All rights reserved.
//

#import "AZAppDelegate.h"

#import "AZViewController.h"

@implementation AZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];//[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[AZViewController alloc] initWithNibName:@"AZViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[AZViewController alloc] initWithNibName:@"AZViewController_iPad" bundle:nil];
    }
    _aDrawView = [[AZDrawView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
//    _aDrawView = [[AZDrawView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    _aDrawView.backgroundColor = [UIColor darkGrayColor];
    _aDrawView.multipleTouchEnabled = YES;
    [self.viewController.view addSubview:_aDrawView];
    [_aDrawView becomeFirstResponder];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
