//
//  ItemSubmission.h
//  Found It!
//
//  Created by Alex Mitchell on 5/1/14.
//  Copyright (c) 2014 Alex Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ItemSubmission : PFObject<PFSubclassing>

@property (retain) PFGeoPoint *location;
@property (retain) PFUser *owner;
@property (retain) NSString *title;



+ (NSString *)parseClassName;

@end