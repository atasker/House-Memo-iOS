//
//  DetailViewController.h
//  NextStep
//
//  Created by Angus Tasker on 2/12/14.
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DejalActivityView.h"
#import "ImageViewController.h"

@interface DetailViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate, ImageViewControllerDelegate>
{
    Notes *notes;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIScrollView *scrlVw;
    IBOutlet UIPickerView *picker;
    UITextField *curTxtField;
    CGRect toolbarRectForKeyboard;
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtAddress;
    IBOutlet UITextField *txtPrice;
    IBOutlet UITextField *txtFootage;
    IBOutlet UITextField *txtBedrooms;
    IBOutlet UITextField *txtBathrooms;
    IBOutlet UITextField *txtAgent;
    IBOutlet UITextField *txtParking;
    IBOutlet UITextField *txtGarden;
    IBOutlet UITextView *txtNotes;
    IBOutlet UIButton *btnAdd;
    IBOutlet UIButton *star1;
    IBOutlet UIButton *star2;
    IBOutlet UIButton *star3;
    IBOutlet UIButton *star4;
    IBOutlet UIButton *star5;
    IBOutlet UILabel *lblRealtor;
    IBOutlet UILabel *lblBackYard;
    NSArray *pickerOptions;
    NSArray *parkingOptions;
    NSArray *gardenOptions;
    NSMutableArray *pictures;
    NSMutableArray *thumbnails;
    NSInteger starCount;
    float contentHeight;
    DejalActivityView *activityIndicator;
}
@property (strong, nonatomic) id noteID;

- (IBAction)doneBtnSelected:(id)sender;

- (IBAction)saveBtnTapped:(id)sender;

- (IBAction)btnScoreTapped:(id)sender;

- (IBAction)btnAddImageTapped:(id)sender;

@end
