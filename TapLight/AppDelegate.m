//
//  AppDelegate.m
//  TapLight
//
//  Created by Andrew Schumacher on 2/9/12.
//  Copyright (c) 2012 XeSys. All rights reserved.
//

#import "AppDelegate.h"
#import "TapLight.h"
#import "TapSettings.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tapNav;
@synthesize launch;


#pragma mark -
#pragma mark Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    TapLight *light = [[TapLight alloc] initWithNibName:@"TapLight" bundle:nil];
    
    // TapSettings *settings = [[TapSettings alloc] initWithNibName:@"TapSettings" bundle:nil];
    
    
    
    
    self.tapNav = [[UINavigationController alloc] initWithRootViewController:light];
     
     
     
    [self.window addSubview:tapNav.view];
    // [self.window addSubview:settings.view];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    
     //Check Application First Run
     
     
     NSUserDefaults *firstRun = [NSUserDefaults standardUserDefaults];
     launch = [firstRun stringForKey:@"launch"];
     
     NSLog(@"First Launch: %@",launch);
     
     
     if (launch == NULL)
     {
     NSUserDefaults *firstSetup = [NSUserDefaults standardUserDefaults];
     
     NSString *launchSetup = [[NSString alloc] initWithFormat:@"no"];
     
     [firstSetup setObject:launchSetup forKey:@"launch"];
     
     NSString *firstAuto = [[NSString alloc] initWithFormat:@"off"];
     NSString *firstShake = [[NSString alloc] initWithFormat:@"off"];
     
     [firstSetup setObject:firstAuto forKey:@"auto_key"];
     [firstSetup setObject:firstShake forKey:@"shake_key"];
     [firstSetup synchronize];
     
     NSLog(@"First Application RUN!!!!");
     }
     else if ([launch isEqualToString:@"no"])
     {
     NSLog(@"NOT FIRST RUN");
     }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
