//
//  Utility.m
//
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import "Utility.h"


@implementation Utility


+ (NSString *)documentDirectoryPathByAppendingFilePath:(NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:filePath];
}


+ (BOOL)isCurrentDeviceiPhone
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return NO;
    else
        return YES;
}

+ (CGRect)getScreenBounds
{
    return [[UIScreen mainScreen] bounds];
}

+ (BOOL)isCurrentDeviceIsInLandscapeMode
{
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown)
        return NO;
    else
        return YES;
}

+ (NSDate *)getDateFromStr:(NSString *)str
{
    //12/30/2013 6:41:45 AM
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy h:mm:ss a"];
    NSDate *date = [format dateFromString:str];
    return date;
}

+ (NSString *)getDateStringFromDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy h:mm:ss a"];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

+ (NSString *)getTimeStringFromDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"H:mm:ss"];
    NSString *timeStr = [format stringFromDate:date];
    return timeStr;
}

+ (NSString *)getOnlyDateStringFromDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}




@end
