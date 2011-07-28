#import <Cocoa/Cocoa.h>

@class WindowController;

@interface TweetyGonzalezAppDelegate : NSObject <NSApplicationDelegate> {
  WindowController *windowController;
}

@property (retain) WindowController *windowController;

@end


@interface WindowController : NSWindowController <NSTableViewDataSource, NSTextFieldDelegate, NSURLConnectionDelegate> {
  NSTextField *searchField;
  NSButton *searchButton;
  NSTableView *tweetsTableView;
  NSArray *tweets;
  NSString *searchURLString;
  NSMutableData *downloadData;
}

@property (retain) NSTextField *searchField;
@property (retain) NSButton *searchButton;
@property (retain) NSTableView *tweetsTableView;
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
