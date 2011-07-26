#import <Foundation/Foundation.h>

@interface StringCalculator : NSObject

- (int)add:(NSString *)string;

@end

@implementation StringCalculator

- (int)add:(NSString *)string {
  // An empty string equals zero.

  /* [REPLACE WITH CODE] */

  // The default number delimiter is `,', but the user can specify a custom
  // one on the first line in the form: //[delimiter]

  /* [REPLACE WITH CODE] */

  // Split the string on the delimiter and new lines, giving us an array of
  // the actual numbers.

  /* [REPLACE WITH CODE] */

  // Iterate over all the numbers and sum them.

  int sum = 0;
  /* [REPLACE WITH CODE] */

  // In case we enoutered any negative values, during summing, we raise.

  /* [REPLACE WITH CODE] */

  return sum;
}

@end

// This function is needed by MacRuby. Normally when creating a MacRuby C
// extension, this is the place where you would initialize the extension.
//
// For a Objective-C bundle we don't need it to do anything, but we *do*
// need to define it, otherwise MacRuby will complain.
void Init_string_calculator() {}
