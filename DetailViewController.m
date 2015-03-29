//
//  DetailViewController.m
//  NextStep
//
//  Created by Angus Tasker on 2/12/14.
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    contentHeight = 850;
    if (self.noteID)
    {
        notes =  [[DAL sharedInstance] fetchRecordForEntity:NOTES_ENTITY_NAME forID:self.noteID];
        txtName.text = notes.title;
        txtAddress.text = notes.address;
        txtPrice.text = notes.price;
        txtFootage.text = [NSString stringWithFormat:@"%ld",(long)notes.squareFootage.integerValue];
        txtBedrooms.text = [NSString stringWithFormat:@"%ld",(long)notes.bedrooms.integerValue];
        txtBathrooms.text = [NSString stringWithFormat:@"%ld",(long)notes.bathrooms.integerValue];
        txtAgent.text = notes.agent;
        txtParking.text = notes.parking;
        txtGarden.text = notes.garden;
        txtNotes.text = notes.notes;
        starCount = notes.starCount?notes.starCount.intValue:0;
        
        [self setUpStars];
        
        
    }
    
    [toolBar setHidden:YES];
    [picker setHidden:YES];
    [txtParking setInputView:picker];
    [txtGarden setInputView:picker];
    
    [scrlVw setContentSize:CGSizeMake(320,contentHeight)];

    parkingOptions = [[NSArray alloc] initWithObjects:@"Single car garage",@"2 car garage",@"Off street", nil];
    gardenOptions = [[NSArray alloc] initWithObjects:@"None",@"Fenced Back yard",@"Open Back yard",@"Back yard with pool", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    txtNotes.layer.borderWidth = 2.0f;
    txtNotes.layer.cornerRadius = 8;
    txtNotes.layer.borderColor = [[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0] CGColor];
    
    btnAdd.layer.borderWidth = 2.0f;
    btnAdd.layer.cornerRadius = 8;
    btnAdd.layer.borderColor = [[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0] CGColor];
}

- (void)setUpImages
{
    int factor = 3;
    int padding = 0;
    if ([Utility isCurrentDeviceIsInLandscapeMode])
    {
        factor = 5;
        padding = 30;
    }
    CGRect rect = CGRectMake(20 + padding, 943, 80, 80);
    int i =0;
    if (!pictures)
    {
        if (notes && notes.pictures)
        {
            NSArray *notesPictures = [notes.pictures allObjects];
            NSSortDescriptor *desc = [[NSSortDescriptor alloc] initWithKey:PICTURE_IMAGE_ID ascending:YES];
            NSArray *descs = [NSArray arrayWithObject:desc];
            notesPictures = [notesPictures sortedArrayUsingDescriptors:descs];
            pictures = [[NSMutableArray alloc] initWithArray:notesPictures];
        }
        else
            pictures = [[NSMutableArray alloc] init];
    }
    if (!thumbnails)
        thumbnails = [[NSMutableArray alloc] init];
    for (UIButton *btn in thumbnails) {
        [btn removeFromSuperview];
    }
    [thumbnails removeAllObjects];
    
    for (Picture *pic in pictures) {
        
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:rect];
        UIImage *img = [UIImage imageWithData:pic.image];
        [imgBtn setImage:img forState:UIControlStateNormal];
        [imgBtn addTarget:self action:@selector(imagetapped:) forControlEvents:UIControlEventTouchUpInside];
        [imgBtn setTag:pic.img_id.intValue];
        [scrlVw addSubview:imgBtn];
        [thumbnails addObject:imgBtn];
        i++;
        
        
        int j = (i)%factor;
        if (j==0)
        {
            rect.origin.x = 20 + padding;
            rect.origin.y +=100;
        }
        else if (j==1)
            rect.origin.x = 120 + padding;
        else if (j == 2)
            rect.origin.x = 220 + padding;
        else if (j == 3)
            rect.origin.x = 320 + padding;
        else if (j == 4)
            rect.origin.x = 420 + padding;
        
        if (i == pictures.count)
        {
            contentHeight =  rect.origin.y-100;
            scrlVw.contentSize = CGSizeMake(320, contentHeight);
        }

        
    }
    btnAdd.frame = rect;
}

- (void)viewDidLayoutSubviews
{
    [self setUpImages];
    if ([Utility isCurrentDeviceIsInLandscapeMode])
    {
        CGRect frame = lblBackYard.frame;
        frame.origin.x = 43;
        lblBackYard.frame = frame;
        
        frame = lblRealtor.frame;
        frame.origin.x = 43;
        lblRealtor.frame = frame;
    }
    else
    {
        CGRect frame = lblBackYard.frame;
        frame.origin.x = 22;
        lblBackYard.frame = frame;
        
        frame = lblRealtor.frame;
        frame.origin.x = 22;
        lblRealtor.frame = frame;
    }
}

- (void)setUpStars
{
    if (starCount>=1)
        [star1 setImage:[UIImage imageNamed:@"FilledStar"] forState:UIControlStateNormal];
    else
        [star1 setImage:[UIImage imageNamed:@"EmptyStar"] forState:UIControlStateNormal];
    
    if (starCount>=2)
        [star2 setImage:[UIImage imageNamed:@"FilledStar"] forState:UIControlStateNormal];
    else
        [star2 setImage:[UIImage imageNamed:@"EmptyStar"] forState:UIControlStateNormal];
    
    if (starCount>=3)
        [star3 setImage:[UIImage imageNamed:@"FilledStar"] forState:UIControlStateNormal];
    else
        [star3 setImage:[UIImage imageNamed:@"EmptyStar"] forState:UIControlStateNormal];
    
    if (starCount>=4)
        [star4 setImage:[UIImage imageNamed:@"FilledStar"] forState:UIControlStateNormal];
    else
        [star4 setImage:[UIImage imageNamed:@"EmptyStar"] forState:UIControlStateNormal];
    
    if (starCount>=5)
        [star5 setImage:[UIImage imageNamed:@"FilledStar"] forState:UIControlStateNormal];
    else
        [star5 setImage:[UIImage imageNamed:@"EmptyStar"] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneBtnSelected:(id)sender {
    if (curTxtField)
    {
        [curTxtField resignFirstResponder];
        curTxtField.text = [pickerOptions objectAtIndex:[picker selectedRowInComponent:0]];
    }
    else
    {
        [txtNotes resignFirstResponder];
        [self moveToolbarForKeyboard:nil up:NO];
    }
    [picker setHidden:YES];
    [toolBar setHidden:YES];
    scrlVw.contentSize = CGSizeMake(320, contentHeight);
}

- (IBAction)saveBtnTapped:(id)sender {
    
    //no data will be saved if no name is inserted
    if (txtName.text && ![txtName.text isEqualToString:@""])
    {
        if (notes)
        {
            notes.title = txtName.text;
            notes.address = txtAddress.text;
            notes.price = txtPrice.text;
            notes.squareFootage = [NSNumber numberWithInteger:txtFootage.text.integerValue];
            notes.bedrooms = [NSNumber numberWithInteger:txtBedrooms.text.integerValue];
            notes.bathrooms = [NSNumber numberWithInteger:txtBathrooms.text.integerValue];
            notes.agent = txtAgent.text;
            notes.parking = txtParking.text;
            notes.garden = txtGarden.text;
            notes.notes = txtNotes.text;
            notes.starCount = [NSNumber numberWithInteger:starCount];
            
        }
        else if(!notes)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:NOTES_ENTITY_NAME forKey:ENTITY_NAME];
            [dict setObject:txtName.text forKey:NOTES_TITLE];
            if (txtAddress.text.length>0)
                [dict setObject:txtAddress.text forKey:NOTES_ADDRESS];
            if (txtPrice.text.length>0)
                [dict setObject:txtPrice.text forKey:NOTES_PRICE];
            if (txtFootage.text.length>0)
                [dict setObject:[NSNumber numberWithInteger:txtFootage.text.integerValue] forKey:NOTES_SQUARE_FOOTAGE];
            if (txtBedrooms.text.length>0)
                [dict setObject:[NSNumber numberWithInteger:txtBedrooms.text.integerValue] forKey:NOTES_BEDROOMS];
            if (txtBathrooms.text.length>0)
                [dict setObject:[NSNumber numberWithInteger:txtBathrooms.text.integerValue] forKey:NOTES_BATHROOMS];
            if (txtAgent.text.length>0)
                [dict setObject:txtAgent.text forKey:NOTES_AGENT];
            if (txtParking.text.length>0)
                [dict setObject:txtParking.text forKey:NOTES_PARKING];
            if (txtGarden.text.length>0)
                [dict setObject:txtGarden.text forKey:NOTES_GARDEN];
            if (txtNotes.text.length>0)
                [dict setObject:txtNotes.text forKey:NOTES_NOTES];
            [dict setObject:[NSNumber numberWithInteger:starCount] forKey:NOTES_STAR_COUNT];
            notes = [[DAL sharedInstance] insertNewEntity:dict];
        }
        notes.pictures = nil;
        if (pictures && pictures.count>0)
            [notes addPictures:[NSSet setWithArray:pictures]];
        
        
        [[DAL sharedInstance] saveContext];
        [self .navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (IBAction)btnScoreTapped:(UIButton *)sender
{
    if (sender.tag == starCount)
    {
        starCount = 0;
    }
    else
    {
        starCount = sender.tag;
    }
    [self setUpStars];
}

- (void)imagetapped:(UIButton *)sender
{
    Picture *pic = [[DAL sharedInstance] fetchRecordForEntity:PICTURE_ENTITY forID:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    [self performSegueWithIdentifier:@"segueImgView" sender:pic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueImgView"])
    {
        ImageViewController *controller = segue.destinationViewController;
        [controller setDelegate:self];
        [controller setPic:sender];
    }
}

- (IBAction)btnAddImageTapped:(id)sender
{
    UIActionSheet *sheetImgSelection = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self
                                                          cancelButtonTitle: nil
                                                     destructiveButtonTitle: @"Cancel"
                                                          otherButtonTitles: @"Camera",@"Gallery", nil];
    [sheetImgSelection showInView:self.view];
}

#pragma mark - Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self showCameraView];
    }
    else if (buttonIndex == 2){
        [self showGallery];
    }
}

-(void) showCameraView {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [self showUIImagePicker:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Your device does not have a camera."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]  show];
    }
}

-(void) showGallery {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        [self showUIImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    else
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Your device does not have Photo Album."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
}

-(void) showUIImagePicker:(UIImagePickerControllerSourceType)type {
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = type;
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark Image Picker delegate
- (void)imagePickerController:(UIImagePickerController *)apicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    img = [self fixrotation:img];
    if (apicker.sourceType == UIImagePickerControllerSourceTypeCamera)
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    activityIndicator = [DejalBezelActivityView activityViewForView:self.view withLabel:@"Saving Image..."];
    [self performSelectorInBackground:@selector(addImage:) withObject:img];
}

- (void)addImage :(UIImage *)img
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSArray *result = [[DAL sharedInstance] fetchRecords:PICTURE_ENTITY sortBy:PICTURE_IMAGE_ID];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:PICTURE_ENTITY forKey:ENTITY_NAME];
    [param setObject:UIImagePNGRepresentation(img) forKey:PICTURE_IMAGE];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)(result?result.count:0)] forKey:PICTURE_IMAGE_ID];
    Picture *pic = [[DAL sharedInstance] insertNewEntity:param];
    [pictures addObject:pic];
    [self performSelectorOnMainThread:@selector(setUpImages) withObject:nil waitUntilDone:YES];
    [activityIndicator removeFromSuperview];
}


# pragma mark- UItextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if  ([curTxtField isEqual:txtPrice] || [curTxtField isEqual:txtFootage] || [curTxtField isEqual:txtBedrooms] || [curTxtField isEqual:txtBathrooms])
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression = @"^([\\d]+)?$";
        if ([curTxtField isEqual:txtPrice])
            expression = @"^([\\d,$£€]+)?$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
        else
            return YES;
    }
    else
        return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [picker setHidden:YES];
    [toolBar setHidden:YES];
    [textField resignFirstResponder];
    curTxtField = nil;
    scrlVw.contentSize = CGSizeMake(320, contentHeight);
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    curTxtField = textField;
    if ([textField isEqual:txtParking] || [textField isEqual:txtGarden])
    {
        if ([textField isEqual:txtParking])
        {
            pickerOptions = parkingOptions;
        }
        else
        {
            pickerOptions = gardenOptions;
        }
        [picker reloadAllComponents];
        [picker setHidden:NO];
        [toolBar setHidden:NO];
    }
    else
    {
        [picker setHidden:YES];
        [toolBar setHidden:YES];
    }
    CGSize size = scrlVw.contentSize;
    if (size.height == contentHeight) size.height +=212;
    scrlVw.contentSize = size;
    [scrlVw setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    curTxtField = nil;
    [toolBar setHidden:NO];
    CGSize size = scrlVw.contentSize;
    if (size.height == contentHeight) size.height +=212;
    scrlVw.contentSize = size;
    float margin = 32;
    if ([Utility isCurrentDeviceIsInLandscapeMode])
        margin = 0;
    [scrlVw setContentOffset:CGPointMake(0, textView.frame.origin.y-margin) animated:YES];
    [self moveToolbarForKeyboard:nil up:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (newString.length > 200)
        return NO;
    else
        return YES;
}


# pragma mark - UIPicker View DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerOptions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerOptions objectAtIndex:row];
}

# pragma mark - UIPicker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [curTxtField setText:[pickerOptions objectAtIndex:row]];
}

#pragma mark - Keboard notification
-(void) keyboardWillShow:(NSNotification*)notification
{
    if ([curTxtField isEqual:txtParking] || [curTxtField isEqual:txtGarden] || !curTxtField)
        [self moveToolbarForKeyboard:notification up:YES];
}

-(void) keyboardWillHide:(NSNotification*)notification
{
    if ([curTxtField isEqual:txtParking] || [curTxtField isEqual:txtGarden] || !curTxtField)
        [self moveToolbarForKeyboard:notification up:NO];
}

- (void) moveToolbarForKeyboard:(NSNotification*)notification up: (BOOL) up
{
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (up)
    {
        float height = (curTxtField)?picker.frame.size.height:212;
        float yPos = [Utility getScreenBounds].size.height - height - toolBar.frame.size.height;
        if ([Utility isCurrentDeviceIsInLandscapeMode])
            yPos = 114;//[Utility getScreenBounds].size.width - height - toolBar.frame.size.height;
        toolbarRectForKeyboard = CGRectMake(0, yPos,toolBar.frame.size.width, toolBar.frame.size.height);
        [toolBar setFrame:CGRectMake(0, [Utility getScreenBounds].size.height - toolBar.frame.size.height, toolBar.frame.size.width, toolBar.frame.size.height)];
        [toolBar setAlpha:1];
        [UIView animateWithDuration:animationDuration animations:^{
            [toolBar setFrame:toolbarRectForKeyboard];
        }];
    }
    else
    {
        
        [UIView animateWithDuration:animationDuration animations:^{
            [toolBar setFrame:CGRectMake(0, [Utility getScreenBounds].size.height - toolBar.frame.size.height, toolBar.frame.size.width, toolBar.frame.size.height)];
            
        } completion:^(BOOL finished){
            if (finished)
            {
                [toolBar setAlpha:0];
                [toolBar setFrame:toolbarRectForKeyboard];
            }
        }];
        
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Metghod for fixing rotation

- (UIImage *)fixrotation:(UIImage *)image{
    
    
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;

}


# pragma mark - ImageViewController Delegate

- (void)picDeleted:(Picture *)pic
{
    [pictures removeObject:pic];
    [self setUpImages];
}



@end
