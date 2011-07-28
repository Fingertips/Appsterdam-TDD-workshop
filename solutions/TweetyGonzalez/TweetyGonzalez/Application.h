#import <Cocoa/Cocoa.h>

@class WindowController;

@interface TweetyGonzalezAppDelegate : NSObject <NSApplicationDelegate> {
  WindowController *windowController;
}

@property (retain) WindowController *windowController;

@end


@interface WindowController : NSWindowController <NSTextFieldDelegate, NSURLConnectionDelegate> {
  NSTextField *searchField;
  NSButton *searchButton;
  NSArray *tweets;
  NSString *searchURLString;
  NSMutableData *downloadData;
}

@property (retain) NSTextField *searchField;
@property (retain) NSButton *searchButton;
@property (retain) NSArray *tweets;
@property (retain) NSString *searchURLString;
@property (retain) NSMutableData *downloadData;

@end


@interface Tweet : NSObject {
  NSXMLElement *entryXMLElement;
}

@property (retain) NSXMLElement *entryXMLElement;

+ (NSArray *)tweetsWithXMLString:(NSString *)xml;

- (id)initWithXMLElement:(NSXMLElement *)entry;

- (NSString *)author;
- (NSString *)message;

@end
