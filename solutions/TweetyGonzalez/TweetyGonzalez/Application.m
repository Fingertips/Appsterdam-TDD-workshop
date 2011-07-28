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
    [column.headerCell setStringValue:@"Author"];
    [tweetsTableView addTableColumn:column];
    column = [[NSTableColumn new] autorelease];
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
  searchButton.enabled = [searchField.stringValue length] != 0;
}

// Perform search query

- (void)performSearch:(id)sender {
  NSString *query = searchField.stringValue;
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:searchURLString, query]];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/atom+xml" forHTTPHeaderField:@"Content-Type"];
  [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  self.downloadData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSString *xml = [[[NSString alloc] initWithData:downloadData encoding:NSUTF8StringEncoding] autorelease];
  self.tweets = [Tweet tweetsWithXMLString:xml];
  [tweetsTableView reloadData];
}

// Tableview data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return [tweets count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)index {
  if ([[tableColumn.headerCell stringValue] isEqualToString:@"Author"]) {
    return [(Tweet *)[tweets objectAtIndex:index] author];
  } else {
    return [(Tweet *)[tweets objectAtIndex:index] message];
  }
}

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
  NSXMLElement *author = [[entryXMLElement elementsForName:@"author"] objectAtIndex:0];
  NSXMLElement *name = [[author elementsForName:@"name"] objectAtIndex:0];
  return [name stringValue];
}

- (NSString *)message {
  NSXMLElement *title = [[entryXMLElement elementsForName:@"title"] objectAtIndex:0];
  return [title stringValue];
}

@end


// This function is needed by MacRuby. Normally when creating a MacRuby C
// extension, this is the place where you would initialize the extension.
//
// For a Objective-C bundle we don't need it to do anything, but we *do*
// need to define it, otherwise MacRuby will complain.
void Init_Application () {}
