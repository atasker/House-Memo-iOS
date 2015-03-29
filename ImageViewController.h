//
//  ImageViewController.h
//  NextStep
//
//  Created by Habib on 4/3/14.
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageViewControllerDelegate <NSObject>

- (void)picDeleted:(Picture *)pic;

@end

@interface ImageViewController : UIViewController
{
    IBOutlet UIImageView *imgVw;
    
}


@property (strong, nonatomic) Picture *pic;
@property (strong, nonatomic) id delegate;

- (IBAction)deletePhoto:(id)sender;

@end
