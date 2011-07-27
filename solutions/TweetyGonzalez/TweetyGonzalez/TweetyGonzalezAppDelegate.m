#import "TweetyGonzalezAppDelegate.h"

@implementation TweetyGonzalezAppDelegate

@synthesize windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  self.windowController = [[WindowController new] autorelease];
  [windowController showWindow:self];
}

@end


@implementation WindowController

- (id)init {
  NSWindow *win = [[[NSWindow alloc] initWithContentRect:NSMakeRect(50, 50, 500, 400)
                                               styleMask:NSTitledWindowMask|NSResizableWindowMask
                                                 backing:NSBackingStoreBuffered
                                                   defer:NO] autorelease];
  if ((self = [super initWithWindow:win])) {
    NSView *contentView = [win contentView];

    NSScrollView *scrollView = [[[NSScrollView alloc] initWithFrame:NSMakeRect(0, 48, 500, 352)] autorelease];
    scrollView.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable;
    [contentView addSubview:scrollView];

    NSTableView *tableView = [[[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 500, 352)] autorelease];
    scrollView.documentView = tableView;

    NSTextField *textField = [[[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, 390, 28)] autorelease];
    textField.autoresizingMask = NSViewWidthSizable;
    [contentView addSubview:textField];

    NSButton *button = [[[NSButton alloc] initWithFrame:NSMakeRect(410, 10, 80, 28)] autorelease];
    button.title = @"Search";
    button.enabled = NO;
    button.bezelStyle = NSRoundedBezelStyle;
    button.autoresizingMask = NSViewMinXMargin;
    [contentView addSubview:button];
  }
  return self;
}

@end
