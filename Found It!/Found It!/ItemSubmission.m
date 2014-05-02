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
@dynamic image;

+ (NSString *)parseClassName {
    return @"item_submission";
}

- (void) saveImage:(UIImage*) image{
    
    image= [self imageWithImage: image
                   scaledToSize: CGSizeMake(100, 100)
            ];
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:UIImagePNGRepresentation(image)];
    self.image = imageFile;
    [self.image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // Handle success or failure here ...
    } progressBlock:^(int percentDone) {
        NSLog(@"%d percent uploaded", percentDone);
    }];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
