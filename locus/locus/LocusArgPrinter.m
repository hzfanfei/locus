//
//  LocusArgPrinter.m
//  locus
//
//  Created by FanFamily on 2019/1/27.
//  Copyright © 2019年 niuniu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LocusArgPrinter.h"

char getTypeFromTypeDescription(const char *typeDescription)
{
    char type = typeDescription[0];
    switch (type) {
        case 'r':
        case 'n':
        case 'N':
        case 'o':
        case 'O':
        case 'R':
        case 'V':
            type = typeDescription[1];
            break;
    }
    return type;
}


void printArgs(uintptr_t arg1, uintptr_t arg2, uintptr_t arg3, id cls, SEL sel)
{
    uintptr_t args[] = {arg1, arg2, arg3};
    NSMethodSignature *signature = [[cls class] instanceMethodSignatureForSelector:sel];
    if ([signature numberOfArguments] > 2) {
        for (NSInteger i = 0; i < [signature numberOfArguments] - 2 && i < 3; i++) {
            const char* typeDescription = [signature getArgumentTypeAtIndex:i + 2];
            char type = getTypeFromTypeDescription(typeDescription);
            switch (type) {
                case '@':
                    {
                        NSString* description = [NSString stringWithFormat:@"%@", args[i]];
                        printf("———— arg%ld: %s\n", i+1, description.UTF8String);
                    }
                    break;
                case 'i':
                case 'l':
                case 'q':
                    printf("———— arg%ld: %ld\n", i+1, args[i]);
                    break;
                case 'f':
                    printf("———— arg%ld: %f\n", i+1, (float)args[i]);
                    break;
                case 'd':
                    printf("———— arg%ld: %lf\n", i+1, (double)args[i]);
                    break;
                default:
                    break;
            }
        }
    }
}
