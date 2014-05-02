//
//  FoundTableViewController.m
//  Found It!
//
//  Created by Alex Mitchell on 5/1/14.
//  Copyright (c) 2014 Alex Mitchell. All rights reserved.
//

#import "FoundTableViewController.h"
#import <Parse/Parse.h>
#import "FoundTableViewCell.h"

@interface FoundTableViewController ()
@property int miles;
@property NSArray* foundObjects;

@end

@implementation FoundTableViewController

-(void) refresh: (id)sender {
    [self getFoundObjects];
    [self.tableView reloadData];
    [(UIRefreshControl *)sender endRefreshing];
}

-(void) getFoundObjects {
    PFGeoPoint *userGeoPoint = [[PFUser currentUser] objectForKey:@"last_location"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"item_submission"];
    [query whereKey:@"location"nearGeoPoint: userGeoPoint withinMiles: _miles];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu found items.", (unsigned long)objects.count);
            _foundObjects = objects;
           
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _miles=1000000000;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    [self refresh:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.foundObjects.count;
}

-(NSString*) timeStringizer:(int) time{
    NSString *string;
    if (time < 60){
        string = [NSString stringWithFormat:@"%d seconds ago", time];
    }
    else if (time < 60*60){
        string = [NSString stringWithFormat:@"%.0f minutes ago", time/60.0];
    }
    else if (time < 60*60*24){
        string = [NSString stringWithFormat:@"%.0f hours ago", time/(60.0 * 60.0)];
    }
    else if (time < 60*60*24*7){
        string = [NSString stringWithFormat:@"%.0f days ago", time/(60.0 * 60.0 * 24.0)];
    }
    else if (time < 60*60*24*7*52){
        string = [NSString stringWithFormat:@"%.0f weeks ago", time/(60.0 * 60.0 * 24.0 * 7.0)];
    }
    else {
        string = [NSString stringWithFormat:@"%.0f years ago", time/(60.0 * 60.0 * 24.0 * 7.0 * 52.0)];
    }
    
    return string;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.title.text = [self.foundObjects[indexPath.row] objectForKey:@"title"];
    cell.timeSinceCreation.text = [self timeStringizer:[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:[self.foundObjects[indexPath.row] createdAt]]];
    cell.distance.text = [NSString stringWithFormat:@"%.1f miles away",[[[PFUser currentUser] objectForKey:@"last_location"] distanceInMilesTo:[self.foundObjects[indexPath.row]objectForKey:@"location"]]];
    
    
    PFFile *imageFile = [self.foundObjects[indexPath.row] objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.image.image = [UIImage imageWithData:imageData];
            [self.tableView reloadData];
        }
    }];
    
    
    
                       
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
