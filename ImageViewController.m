//
//  ImageViewController.m
//  NextStep
//
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

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
    // Do any additional setup after loading the view.
    if (self.pic)
       [imgVw setImage:[UIImage imageWithData:self.pic.image]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    UIImage *image = [UIImage imageWithData:self.pic.image];
    CGSize imgSize = image.size;
    CGSize screenSize = [Utility getScreenBounds].size;
    float factor = imgSize.width/screenSize.width;
    imgSize.width = screenSize.width;
    imgSize.height /= factor;

    if ([Utility isCurrentDeviceIsInLandscapeMode])
    {
        imgVw.frame = CGRectMake((screenSize.height - imgSize.width)/2,(screenSize.width - imgSize.height)/2 + 32,imgSize.width,imgSize.height);

    }
    else
    {
        imgVw.frame = CGRectMake((screenSize.width - imgSize.width)/2,(screenSize.height - imgSize.height)/2 + 32,imgSize.width,imgSize.height);
    }
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

- (IBAction)deletePhoto:(id)sender {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to delete the picture?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=alertView.cancelButtonIndex)
    {
        [[[DAL sharedInstance] managedObjectContext] deleteObject:self.pic];
        [[DAL sharedInstance] saveContext];

        if (self.delegate && [self.delegate respondsToSelector:@selector(picDeleted:)])
            [self.delegate picDeleted:self.pic];
        [self.navigationController popViewControllerAnimated:YES];

    }
}

@end
