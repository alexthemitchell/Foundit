//
//  SubmitViewController.m
//  Found It!
//
//  Created by Alex Mitchell on 5/1/14.
//  Copyright (c) 2014 Alex Mitchell. All rights reserved.
//

#import "SubmitViewController.h"
#import <Parse/Parse.h>
#import "ItemSubmission.h"

@interface SubmitViewController ()
@property ItemSubmission* submission;
@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@end

@implementation SubmitViewController
- (IBAction)submitClicked:(id)sender {
    NSLog(@"Clicked");
    [[self submission] setTitle:self.itemTitle.text];
    [[self submission] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There's been a problem." delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            [alert show];
        }
        else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"It's been saved!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        }
    }];
    [self resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.submission = [ItemSubmission new];
    
    [[self submission] setOwner: [PFUser currentUser]];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        [[self submission] setLocation: geoPoint];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
