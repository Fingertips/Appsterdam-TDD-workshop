#import <Cocoa/Cocoa.h>

@class WindowController;

@interface TweetyGonzalezAppDelegate : NSObject <NSApplicationDelegate> {
  WindowController *windowController;
}

@property (retain) WindowController *windowController;

@end


@interface WindowController : NSWindowController <NSTextFieldDelegate> {
  NSTextField *searchField;
  NSButton *searchButton;
}

@property (retain) NSTextField *searchField;
@property (retain) NSButton *searchButton;

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
