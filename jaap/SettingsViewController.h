//
//  SettingsViewController.h
//  jaap
//
//  Created by manoj sk on 7/30/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SettingsViewController : UIViewController <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) FBSDKLoginButton *loginButton;

@end

