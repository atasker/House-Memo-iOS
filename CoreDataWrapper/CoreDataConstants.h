#import <Foundation/Foundation.h>

//For Debuglog
#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#else
#define DLog(...) do { } while (0)
#ifndef NS_BLOCK_ASSERTIONS
#define NS_BLOCK_ASSERTIONS
#endif //#define ALog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#endif
#define ZAssert(condition, ...) do { if (!(condition)) { ALog(__VA_ARGS__); }} while(0)


@interface CoreDataConstants : NSObject

//Notes Contants

extern NSString *const NOTES_ENTITY_NAME;
extern NSString *const NOTES_TITLE;
extern NSString *const NOTES_ADDRESS;
extern NSString *const NOTES_PRICE;
extern NSString *const NOTES_SQUARE_FOOTAGE;
extern NSString *const NOTES_BEDROOMS;
extern NSString *const NOTES_BATHROOMS;
extern NSString *const NOTES_AGENT;
extern NSString *const NOTES_PARKING;
extern NSString *const NOTES_GARDEN;
extern NSString *const NOTES_NOTES;
extern NSString *const NOTES_STAR_COUNT;

// Pictures constants


extern NSString *const PICTURE_ENTITY;
extern NSString *const PICTURE_IMAGE;
extern NSString *const PICTURE_IMAGE_ID;


@end

