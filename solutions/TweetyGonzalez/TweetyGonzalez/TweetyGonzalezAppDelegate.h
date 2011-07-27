#import <Cocoa/Cocoa.h>

@class WindowController;

@interface TweetyGonzalezAppDelegate : NSObject <NSApplicationDelegate> {
  WindowController *windowController;
}

@property (retain) WindowController *windowController;

@end


@interface WindowController : NSWindowController
@end
