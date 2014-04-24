//
//  RootWindow.m
//  ConvertUnicodeToString
//
//  Created by leiym on 4/21/14.
//  Copyright (c) 2014 leiym. All rights reserved.
//

#import "RootWindow.h"

@interface RootWindow ()

@end

@implementation RootWindow

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:NSControlTextDidChangeNotification object:nil];
}

- (void)textDidChange:(NSNotification *)note {
    if (note.object == self.mainTextField) {
        NSString * unicodeStr = self.mainTextField.stringValue;
        NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
        NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
        NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                               mutabilityOption:NSPropertyListImmutable
                                                                         format:NULL
                                                               errorDescription:NULL];
        [self.mainTextField setStringValue:[returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"]];
    }
}

- (void)close {
    [super close];
    [[NSApplication sharedApplication] terminate:self];
}

@end
