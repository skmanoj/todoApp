//
//  SettingsViewController.m
//  jaap
//
//  Created by manoj sk on 7/30/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SettingsViewController()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SettingsViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	[self setTitle:@"Settings"];
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setLoginButton:[[FBSDKLoginButton alloc] init]];
	[[self loginButton] setFrame:CGRectMake(80, 80, 160, 40)];
	[[self view] addSubview:[self loginButton]];
	[[self loginButton] setDelegate:self];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
	NSLog(@"not required function");
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
	[[[[self view] window] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
