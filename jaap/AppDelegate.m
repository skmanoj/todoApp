//
//  AppDelegate.m
//  jaap
//
//  Created by manoj sk on 7/25/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setClient:[MSClient clientWithApplicationURLString:@"https://jaapmobile-staging.azurewebsites.net"]];	

	[self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];

	[FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
	[[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

	if ([FBSDKAccessToken currentAccessToken])
	{
		[[self window] setRootViewController:[self initializeMainViewController]];
	}
	else
	{
		[self setStoryBoard:[UIStoryboard storyboardWithName:@"Login" bundle:nil]];
		[self setLoginViewController:[[self storyBoard] instantiateViewControllerWithIdentifier:@"loginStoryBoard"]];
		[[self window] setRootViewController:[self loginViewController]];
	}
	[[self window] makeKeyAndVisible];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	
	BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
															openURL:url
														sourceApplication:sourceApplication
															   annotation:annotation];
	// Add any custom logic here.
	return handled;
}

- (UITabBarController*) initializeMainViewController
{
	[self setMainViewController:[[MainViewController alloc] initWithNibName:@"Main" bundle:nil]];
	[self setSettingsViewController:[[SettingsViewController alloc] initWithNibName:@"Settings" bundle:nil]];
	
	[self setMainNavViewController:[[UINavigationController alloc] initWithRootViewController:[self mainViewController]]];
	[self setSettingsNavViewController:[[UINavigationController alloc] initWithRootViewController:[self SettingsViewController]]];
	
	[self setControllers: [NSArray arrayWithObjects:[self mainNavViewController], [self settingsNavViewController], nil]];
	
	[self setTabBarController:[[UITabBarController alloc] init]];
	[[self tabBarController] setViewControllers:[self controllers] animated:YES];
	return [self tabBarController];
}

@end
