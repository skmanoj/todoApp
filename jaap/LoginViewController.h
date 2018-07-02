//
//  LoginViewController.h
//  jaap
//
//  Created by manoj sk on 7/25/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

