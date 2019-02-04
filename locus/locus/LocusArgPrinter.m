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

bool isTaggedPointer(id this)
{
#if SUPPORT_TAGGED_POINTERS
    return ((uintptr_t)this & TAG_MASK);
#else
    return false;
#endif
}

void printArgs(char *class_name, char* sel, va_list argp)
{
    NSString* sClass = [NSString stringWithFormat:@"%s", class_name];
    NSString* sSelector = [NSString stringWithFormat:@"%s", sel];
    Class cls = NSClassFromString(sClass);
    SEL selector = NSSelectorFromString(sSelector);
    NSMethodSignature *signature = [cls instanceMethodSignatureForSelector:selector];
    if ([signature numberOfArguments] > 2) {
        for (NSInteger i = 0; i < [signature numberOfArguments] - 2; i++) {
            const char* typeDescription = [signature getArgumentTypeAtIndex:i + 2];
            char type = getTypeFromTypeDescription(typeDescription);
            BOOL isSupport = YES;
            switch (type) {
                case '@':
                {
                    id obj = va_arg(argp, id);
                    printf("———— arg%ld: %p\n", i+1, (void *)obj);
                }
                    break;
                case 'B':
                    printf("———— arg%ld: %d\n", i+1, va_arg(argp, int));
                    break;
                case 'i':
                    printf("———— arg%ld: %d\n", i+1, va_arg(argp, int));
                    break;
                case 'l':
                    printf("———— arg%ld: %ld\n", i+1, va_arg(argp, long));
                    break;
                case 'q':
                    printf("———— arg%ld: %llu\n", i+1, va_arg(argp, long long));
                    break;
                case 'Q':
                    printf("———— arg%ld: %llu\n", i+1, va_arg(argp, unsigned long long));
                    break;
                case 'f':
                case 'd':
                    printf("———— arg%ld: %lf\n", i+1, va_arg(argp, double));
                    break;
                case ':':
                    printf("———— arg%ld: %s\n", i+1, va_arg(argp, char *));
                    break;
                default:
                    printf("———— arg%ld: %s not support\n", i+1, typeDescription);
                    isSupport = NO;
                    break;
            }
            if (!isSupport) {
                break;
            }
        }
    }
}
