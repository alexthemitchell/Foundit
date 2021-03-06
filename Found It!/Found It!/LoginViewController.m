//
//  LoginViewController.m
//  Found It!
//
//  Created by Alex Mitchell on 5/1/14.
//  Copyright (c) 2014 Alex Mitchell. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController ()
@property CLLocationManager* locationManager;

@end

@implementation LoginViewController
- (IBAction)loginWithFacebook:(id)sender {
    
    [PFFacebookUtils logInWithPermissions:@[@"public_profile",@"email"] block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Store the current user's Facebook ID on the user
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                             forKey:@"fbId"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"gender"]
                                             forKey:@"gender"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"locale"]
                                             forKey:@"locale"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"email"]
                                             forKey:@"email"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"first_name"]
                                             forKey:@"first_name"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"last_name"]
                                             forKey:@"last_name"];
                    [[PFUser currentUser] saveInBackground];
                }
            }];
            
            [self performSegueWithIdentifier:@"loggedIn" sender:self];
        } else {
            NSLog(@"User logged in through Facebook!");
            
            [self performSegueWithIdentifier:@"loggedIn" sender:self];
        }
    }];
    
}


-(void) viewDidAppear:(BOOL)animated{
    
    if ([PFUser currentUser]){
        NSLog(@"Cache Logged in");
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

 }


@end
