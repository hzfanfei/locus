//
//  Locus.m
//  locus
//
//  Created by FanFamily on 2019/1/26.
//  Copyright © 2019年 niuniu. All rights reserved.
//

#import "Locus.h"
#import <objc/runtime.h>

static id filerBlockHolder = nil;

@implementation Locus

+ (NSArray *)getClassNamesFromBundle {
    NSMutableArray* classNames = [NSMutableArray array];
    unsigned int count = 0;
    const char** classes = objc_copyClassNamesForImage([[[NSBundle mainBundle] executablePath] UTF8String], &count);
    for(unsigned int i=0;i<count;i++){
        NSString* className = [NSString stringWithUTF8String:classes[i]];
        [classNames addObject:className];
    }
    return classNames;
}

int reality(Class cls, SEL sel)
{
    unsigned int methodCount;
    Method *methods = class_copyMethodList(cls, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        if (selector == sel) {
            return 1;
        }
    }
    free(methods);
    return 0;
}

+ (void)start
{
    NSArray* classNames = [self getClassNamesFromBundle];
    
    id filter = ^int(char *className, char *selName) {
        NSString* sClass = [NSString stringWithFormat:@"%s", className];
        NSString* sSelector = [NSString stringWithFormat:@"%s", selName];
        Class klass = objc_getClass(className);
        if ([classNames containsObject:sClass]
            && reality(klass, NSSelectorFromString(sSelector))){
            return 1;
        }
        return 0;
    };
    filerBlockHolder = filter;
    lcs_start(filerBlockHolder);
}

@end
