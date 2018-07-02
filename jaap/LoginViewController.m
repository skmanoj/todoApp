//
//  LoginViewController.m
//  jaap
//
//  Created by manoj sk on 7/25/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController() <FBSDKLoginButtonDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) MainViewController *mainViewController;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (![FBSDKAccessToken currentAccessToken])
	{
		// User is logged in, do work such as go to next view controller.
		[self setLoginButton:[[FBSDKLoginButton alloc] init]];
		[[self loginButton] setReadPermissions:@[@"public_profile", @"email", @"user_friends"]];
		[[self loginButton] setDelegate:self];
		[[self view] addSubview:[self loginButton]];
		
		[self setIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
		[[self indicator] setFrame:CGRectMake(0, 0, 40, 40)];
		[[self indicator] setCenter:[[self view] center]];
		[[self view] addSubview:[self indicator]];
		[[self indicator] stopAnimating];
	}
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
	[[self indicator] stopAnimating];
	if (result.grantedPermissions)
	{
		NSLog(@"redirect to main page");
		AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		[self presentViewController:[appDelegate initializeMainViewController] animated:YES completion:nil];
	}
	else
	{
		NSLog(@"cancelled login");
		[[self loginButton] setHidden:false];
	}
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
	NSLog(@"Log out button clicked");
}

- (BOOL) loginButtonWillLogin:(FBSDKLoginButton *)loginButton
{
	NSLog(@"Login button clicked");
	[[self loginButton] setHidden:true];
	[[self indicator] startAnimating];
	return YES;
}

//- (void)viewWillAppear:(BOOL)animated
//	{
//	[super viewWillAppear:animated];
//	if ([FBSDKAccessToken currentAccessToken]) {
//		[[self loginButton] removeFromSuperview];
//		[FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//		FBSDKProfile* cur = [FBSDKProfile currentProfile];
//		[[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name,gender"}]
//		 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//			 if (!error) {
//				 NSLog(@"fetched: %@", result);
//			 }
//		 }];
//		NSLog(@"name: %@",[[FBSDKProfile currentProfile] firstName] );
//	}
//}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
