//
//  MasterViewController.m
//  NextStep
//
//  Created by Angus Tasker on 2/12/14.
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"


#define kDetailView @"showDetail"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"haveTappedAddButton"])
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [Utility getScreenBounds].size.height)];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        [view setAlpha:0.7];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, ([Utility getScreenBounds].size.height - 64 - 240)/2, 280, 240)];
        [label setText:@"House Memo helps you stay organized by compiling important property details in one friendly, easy to use app.\nJust touch the plus sign to begin!"];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:@"ArchitectsDaughter" size:17.0]];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(270, 15, 50, 50)];
        [btn setImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(insertNewObject:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [view addSubview:label];
        [view setTag:1000];
        [self.navigationController.view addSubview:view];
        
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    ///This ensures the re-generation of list items in Table View after new saves or edits.
    [super viewWillAppear:animated];
    [self makeObjects];
    [self.tableView reloadData];
    
}

-(void)makeObjects
{
    ///This ensures list is generated in order of creation date & time.

    _objects = [[NSMutableArray alloc]initWithArray:[[DAL sharedInstance] fetchRecords:NOTES_ENTITY_NAME sortBy:NOTES_TITLE]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if ([self.navigationController.view viewWithTag:1000])
    {
        [[self.navigationController.view viewWithTag:1000] removeFromSuperview];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"haveTappedAddButton"];
    [defaults synchronize];
    [self performSegueWithIdentifier:kDetailView sender:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

   // NSDate *object = _objects[indexPath.row];
    Notes *note =[_objects objectAtIndex:indexPath.row];
    ///This determines which data is used to generate cell title in Table View.
    cell.textLabel.text = note.title;//[[Data getAllNotes] objectForKey:[object description]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ///This controls Editing Style of how Notes are deleted.
        Notes *note = [_objects objectAtIndex:indexPath.row];
        [_objects removeObjectAtIndex:indexPath.row];
        [[[DAL sharedInstance] managedObjectContext] deleteObject:note];
        [[DAL sharedInstance]saveContext];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender && [[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Notes *object = _objects[indexPath.row];
        [[segue destinationViewController] setNoteID:object.title];
    }
}

@end
