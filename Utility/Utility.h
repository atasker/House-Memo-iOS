//
//  Utility.h
//
//  Copyright (c) 2014 Angus Tasker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utility : NSObject


+ (BOOL)isCurrentDeviceiPhone;

+ (CGRect)getScreenBounds;

+ (BOOL)isCurrentDeviceIsInLandscapeMode;

+ (NSString *)documentDirectoryPathByAppendingFilePath:(NSString *)filePath;

+ (NSDate *)getDateFromStr:(NSString *)str;

+ (NSString *)getDateStringFromDate:(NSDate *)date;

+ (NSString *)getTimeStringFromDate:(NSDate *)date;

+ (NSString *)getOnlyDateStringFromDate:(NSDate *)date;



@end
