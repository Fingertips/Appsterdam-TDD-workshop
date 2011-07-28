#import "Application.h"

@implementation TweetyGonzalezAppDelegate

@synthesize windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  self.windowController = [[WindowController new] autorelease];
  [windowController showWindow:self];
}

@end


@implementation WindowController

@synthesize searchField, searchButton;

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

    searchField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, 390, 28)];
    searchField.autoresizingMask = NSViewWidthSizable;
    searchField.delegate = self;
    [contentView addSubview:searchField];

    searchButton = [[NSButton alloc] initWithFrame:NSMakeRect(410, 10, 80, 28)];
    searchButton.title = @"Search";
    searchButton.enabled = NO;
    searchButton.bezelStyle = NSRoundedBezelStyle;
    searchButton.autoresizingMask = NSViewMinXMargin;
    [contentView addSubview:searchButton];
  }
  return self;
}

- (void)dealloc {
  self.searchField = nil;
  self.searchButton = nil;
  [super dealloc];
}

- (void)controlTextDidChange:(NSNotification *)aNotification {
  searchButton.enabled = [searchField.stringValue length] != 0;
}

@end


// This function is needed by MacRuby. Normally when creating a MacRuby C
// extension, this is the place where you would initialize the extension.
//
// For a Objective-C bundle we don't need it to do anything, but we *do*
// need to define it, otherwise MacRuby will complain.
void Init_Application () {}
