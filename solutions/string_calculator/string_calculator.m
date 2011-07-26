#import <Foundation/Foundation.h>

@interface StringCalculator : NSObject

- (int)add:(NSString *)string;

@end

@implementation StringCalculator

- (int)add:(NSString *)string {
  return 0;
}

@end

// This function is needed by MacRuby. Normally when creating a MacRuby C
// extension, this is the place where you would initialize the extension.
//
// For a Objective-C bundle we don't need it to do anything, but we *do*
// need to define it, otherwise MacRuby will complain.
void Init_string_calculator() {}
