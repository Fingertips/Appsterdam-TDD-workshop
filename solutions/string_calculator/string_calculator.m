#import <Foundation/Foundation.h>

@interface StringCalculator : NSObject

- (int)add:(NSString *)string;

@end

@implementation StringCalculator

- (int)add:(NSString *)string {
  // An empty string equals zero.
  if ([string length] == 0) {
    return 0;
  }

  // The default number delimiter is `,', but the user can specify a custom
  // one on the first line in the form: //[delimiter]
  NSString *delimiter = @",";
  if ([string hasPrefix:@"//"]) {
    if ([string characterAtIndex:3] != '\n') {
      [NSException raise:@"ArgumentError"
                  format:@"The custom delimiter has to be on the first line, numbers on the next."];
    }
    delimiter = [string substringWithRange:NSMakeRange(2, 1)];
    string = [string substringWithRange:NSMakeRange(4, [string length] - 4)];
  }

  // Split the string on the delimiter and new lines, giving us an array of
  // the actual numbers.
  NSMutableCharacterSet *characterSet = [[NSMutableCharacterSet new] autorelease];
  [characterSet addCharactersInString:@"\n"];
  [characterSet addCharactersInString:delimiter];
  NSArray *numbers = [string componentsSeparatedByCharactersInSet:characterSet];

  NSMutableArray *negatives = [NSMutableArray array];

  // Iterate over all the numbers and sum them.
  int sum = 0;
  for (NSString *stringNumber in numbers) {
    if ([stringNumber length] == 0) {
      [NSException raise:@"ArgumentError"
                  format:@"Empty values are not allowed."];
    }
    int number = [stringNumber intValue];
    if (number < 0) {
      [negatives addObject:stringNumber];
    }
    sum += number;
  }

  // In case we enoutered any negative values, during summing, we raise.
  if ([negatives count] != 0) {
    NSString *stringNegatives = [negatives componentsJoinedByString:@", "];
    [NSException raise:@"ArgumentError"
                format:@"Negative numbers are not allowed: %@", stringNegatives];
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
