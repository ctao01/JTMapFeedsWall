//
//  JTRootViewController.m
//  JTMapFeedsWaall
//
//  Created by Joy Tao on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JTRootViewController.h"
#import "JTTabBarController.h"

@interface JTRootViewController ()

@end

@implementation JTRootViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![PFUser currentUser])
    {
        PFLogInViewController * logInViewController = [[PFLogInViewController alloc]init];
        [logInViewController setDelegate:self];
        [logInViewController setFields:PFLogInFieldsUsernameAndPassword | PFLogInFieldsPasswordForgotten | PFLogInFieldsFacebook  | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton ];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"user_about_me",
                                                     @"user_relationships",@"user_birthday",@"user_location",
                                                     @"offline_access", nil]];
        
        [self presentViewController:logInViewController 
                           animated:YES 
                         completion:NULL];
        
        PFSignUpViewController * signUpViewController = [[PFSignUpViewController alloc]init];
        [signUpViewController setDelegate:self];
        [signUpViewController setFields:PFSignUpFieldsDefault];
        
        [logInViewController setSignUpController:signUpViewController];
        
    }
    
    JTTabBarController * jtTabBarController = [[JTTabBarController alloc]init];
    [self.navigationController pushViewController:jtTabBarController animated:YES];
}

#pragma mark - PFLogInViewController Delegate Method

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"auth:%@",[user description]);
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - PFSignUpViewController Delegate Method

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{   
    NSMutableArray * newCollections = [[NSMutableArray alloc]init];
    [user setObject:newCollections forKey:@"collections"];
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];

}

@end
