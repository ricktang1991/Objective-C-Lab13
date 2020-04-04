//
//  main.m
//  Lab13
//
//  Created by 桑染 on 2020-04-04.
//  Copyright © 2020 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *stringByPigLatinization(NSString *string) {
    NSArray *vowels = @[@"a",@"e",@"i",@"o",@"u"];
    NSMutableString *result = [NSMutableString new];
    for (int i = 0; i < string.length; i++) {
        NSString *temp = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        if ([vowels containsObject:temp]) {
            [result appendString:[string substringFromIndex:i]];
            [result appendString:[string substringToIndex:i]];
            [result appendString:@"ay"];
            break;
        }
    }
    return result;
}

NSString *getUswerInput(int maxLength) {
    if (maxLength < 1) {
        maxLength = 255;
    }
    char inputChars[maxLength];
    char *result = fgets(inputChars, maxLength, stdin);
    if (result != NULL) {
        // turn cstring -> NSString
        return [[NSString stringWithUTF8String: inputChars] stringByTrimmingCharactersInSet: [NSCharacterSet
            whitespaceAndNewlineCharacterSet]];
        
    }
    return NULL;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *strInput = getUswerInput(255);
        NSMutableArray *inputArray = [NSMutableArray new];
        NSInteger temp = 0;
        for (int i = 0; i < strInput.length; i++) {
            NSString *space = [NSString stringWithFormat:@"%c", [strInput characterAtIndex:i]];
            if ([space isEqual: @" "]) {
                [inputArray addObject:[strInput substringWithRange:NSMakeRange(temp, i)]];
                temp = i + 1;
            } else if (i == strInput.length - 1) {
                [inputArray addObject:[strInput substringFromIndex:temp]];
            }
        }
        NSMutableString *result = [NSMutableString new];
        for (int i = 0; i < inputArray.count; i++) {
            NSString *word = stringByPigLatinization(inputArray[i]);
            word = [word lowercaseString];
            word = [word stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[word substringToIndex:1] capitalizedString]];
            [result appendString:word];
            [result appendString:@" "];
        }
        NSLog(@"%@", result);
    }
    return 0;
}
