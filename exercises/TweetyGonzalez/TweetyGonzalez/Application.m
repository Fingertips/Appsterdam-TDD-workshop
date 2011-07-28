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

@synthesize searchField, searchButton, tweetsTableView, tweets, searchURLString, downloadData;

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

    NSTableColumn *column;
    tweetsTableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 500, 352)];
    tweetsTableView.dataSource = self;
    column = [[NSTableColumn new] autorelease];
    column.width = 200;
    [column.headerCell setStringValue:@"Author"];
    [tweetsTableView addTableColumn:column];
    column = [[NSTableColumn new] autorelease];
    column.width = 300;
    column.resizingMask = NSTableColumnAutoresizingMask;
    [column.headerCell setStringValue:@"Message"];
    [tweetsTableView addTableColumn:column];
    scrollView.documentView = tweetsTableView;

    searchField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, 390, 28)];
    searchField.autoresizingMask = NSViewWidthSizable;
    searchField.delegate = self;
    [contentView addSubview:searchField];

    searchButton = [[NSButton alloc] initWithFrame:NSMakeRect(410, 10, 80, 28)];
    searchButton.title = @"Search";
    searchButton.enabled = NO;
    searchButton.bezelStyle = NSRoundedBezelStyle;
    searchButton.autoresizingMask = NSViewMinXMargin;
    searchButton.target = self;
    searchButton.action = @selector(performSearch:);
    [contentView addSubview:searchButton];

    self.tweets = [NSArray array];
    self.searchURLString = @"http://search.twitter.com/search.atom?q=%@";
  }
  return self;
}

- (void)dealloc {
  self.searchField = nil;
  self.searchButton = nil;
  self.tweetsTableView = nil;
  self.tweets = nil;
  self.searchURLString = nil;
  self.downloadData = nil;
  [super dealloc];
}

- (void)controlTextDidChange:(NSNotification *)aNotification {
  // Only enable the searchButton when the searchField actually contains text
}

// Perform search query

- (void)performSearch:(id)sender {
  // Create an asynchronous call with NSURLConnection
}

// Tableview data source

// ...

@end


@implementation Tweet

@synthesize entryXMLElement;

+ (NSArray *)tweetsWithXMLString:(NSString *)xml {
  NSMutableArray *tweets = [NSMutableArray array];
  NSXMLDocument *doc     = [[[NSXMLDocument alloc] initWithXMLString:xml options:0 error:NULL] autorelease];
  NSArray *entries       = [[doc rootElement] elementsForName:@"entry"];
  for (NSXMLElement *entry in entries) {
    [tweets addObject:[[[Tweet alloc] initWithXMLElement:entry] autorelease]];
  }
  return [[tweets copy] autorelease];
}

- (id)initWithXMLElement:(NSXMLElement *)entry {
  if ((self = [super init])) {
    self.entryXMLElement = entry;
  }
  return self;
}

- (void)dealloc {
  self.entryXMLElement = nil;
  [super dealloc];
}

- (NSString *)author {
  return @"";
}

- (NSString *)message {
  return @"";
}

@end


// This function is needed by MacRuby. Normally when creating a MacRuby C
// extension, this is the place where you would initialize the extension.
//
// For a Objective-C bundle we don't need it to do anything, but we *do*
// need to define it, otherwise MacRuby will complain.
void Init_Application () {}
