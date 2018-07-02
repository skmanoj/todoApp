//
//  AppDelegate.h
//  jaap
//
//  Created by manoj sk on 7/25/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SFSafariViewController.h>
#import <MicrosoftAzureMobile/MicrosoftAzureMobile.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) UINavigationController *mainNavViewController;
@property (strong, nonatomic) SettingsViewController *SettingsViewController;
@property (strong, nonatomic) UINavigationController *settingsNavViewController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) UIStoryboard* storyBoard;
@property (strong, nonatomic) NSArray* controllers;
@property (strong, nonatomic) MSClient *client;

- (UITabBarController*) initializeMainViewController;
@end
