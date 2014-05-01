//
//  ItemSubmission.m
//  Found It!
//
//  Created by Alex Mitchell on 5/1/14.
//  Copyright (c) 2014 Alex Mitchell. All rights reserved.
//

#import "ItemSubmission.h"
#import <Parse/PFObject+Subclass.h>



@implementation ItemSubmission
@dynamic location;
@dynamic owner;
@dynamic title;

+ (NSString *)parseClassName {
    return @"item_submission";
}
@end
