//
//  JOECurrencyUtil.m
//
//  Version 0.1.0
//
//  Created by Joseph Collins on 1/18/14.
//
//  Distributed under The MIT License (MIT)
//  Get the latest version here:
//
//  http://www.github.com/ijoecollins/JOECurrencyUtil
//
//  Copyright (c) 2014 Joseph Collins.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "JOECurrencyUtil.h"

@implementation JOECurrencyUtil

+ (NSCharacterSet *)removableCharacterSet
{
    NSMutableCharacterSet *charactersToKeep = [NSMutableCharacterSet decimalDigitCharacterSet];
    [charactersToKeep addCharactersInString:[self currencyFormatter:2].decimalSeparator];
    
    NSCharacterSet *charactersToRemove = [charactersToKeep invertedSet];
    
    return charactersToRemove;
}

/*! Method converts a string formatted as currency to a decimal number object with a scale of 2.
 
 @b Example: @"$10,545.32" -> 10545.32
 
 @param string NSString argument to be converted to a decimal number
 @return The resulting NSDecimalNumber object.
 */
+ (NSDecimalNumber *)decimalNumberFromCurrencyString:(NSString *)string
{
    return [self decimalNumberFromCurrencyString:string scale:2];
}

/*! Method converts a string formatted as currency to a decimal number object with a given scale argument.
 
 @b Example: Given scale:4, @"$0.0045" -> 0.0045
 
 @param string NSString argument to be converted to a decimal number
 @param scale The number of digits a rounded value should have after its decimal point.
 @return The resulting NSDecimalNumber object.
 */
+ (NSDecimalNumber *)decimalNumberFromCurrencyString:(NSString *)string scale:(short)scale
{
    NSString *cleanString = [self cleanCurrencyString:string];
    unsigned long long mantissa = strtoull([cleanString UTF8String], NULL, 10);
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithMantissa:mantissa exponent:(-1 * scale) isNegative:NO];
    
    return decimalNumber;
}

/*! Method converts a decimal number to a string with 2 digits after its decimal point.
 
 @param number The NSDecimalNumber to be converted to a NSString
 @return The resulting NSString.
 */
+ (NSString *)stringFromDecimalNumber:(NSDecimalNumber *)number
{
    return [self stringFromDecimalNumber:number scale:2];
}

/*! Method converts a decimal number to a string with a given scale.
 
 @param number The NSDecimalNumber to be converted to a NSString
 @param scale The number of digits a rounded value should have after its decimal point.
 @return The resulting NSString.
 */
+ (NSString *)stringFromDecimalNumber:(NSDecimalNumber *)number scale:(short)scale
{
    return [[self currencyFormatter:scale] stringFromNumber:number];
}

/*! This method cleans a NSString representing currency.  It takes an inverted decimalDigitCharacterSet to remove currency symbols, commas, and decimals.
 
 @param string The string to be cleaned.
 @return The resulting digit only string.
 */
+ (NSString *)cleanCurrencyString:(NSString *)string
{
    NSCharacterSet *invertedDecimalSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:invertedDecimalSet];
    NSString *_cleanString = [components componentsJoinedByString:@""];
    
    return _cleanString;
}


+ (NSNumberFormatter *)currencyFormatter:(short)scale
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setGeneratesDecimalNumbers: YES];
    
    if (scale) {
        [formatter setMinimumFractionDigits:scale];
    }
    
    return formatter;
}

@end