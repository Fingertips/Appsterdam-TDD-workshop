#import <Foundation/Foundation.h>

@interface StringCalculator : NSObject

- (int)add:(NSString *)string;

@end

@implementation StringCalculator

- (int)add:(NSString *)string {
  NSString *delimiter = @",";
  if ([string hasPrefix:@"//"]) {
    if ([string characterAtIndex:3] != '\n') {
      NSLog(@"RAISE!");
      return 0;
    }
    delimiter = [string substringWithRange:NSMakeRange(2, 1)];
    string = [string substringWithRange:NSMakeRange(4, [string length] - 4)];
  }

  NSMutableCharacterSet *characterSet = [[NSMutableCharacterSet new] autorelease];
  [characterSet addCharactersInString:@"\n"];
  [characterSet addCharactersInString:delimiter];
  NSArray *numbers = [string componentsSeparatedByCharactersInSet:characterSet];

  // TODO raise for empty components

  int sum = 0;
  for (NSString *x in numbers) {
    int number = [x intValue];
    if (number < 0) {
      // TODO raise for negatives
    }
    sum += number;
  }

  return sum;
}

@end

// This function is needed by MacRuby. Normally when creating a MacRuby C
// extension, this is the place where you would initialize the extension.
//
// For a Objective-C bundle we don't need it to do anything, but we *do*
// need to define it, otherwise MacRuby will complain.
void Init_string_calculator() {}
