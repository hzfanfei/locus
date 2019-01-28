//
//  Locus.m
//  locus
//
//  Created by FanFamily on 2019/1/26.
//  Copyright © 2019年 niuniu. All rights reserved.
//

#import "Locus.h"
#import "LocusView.h"
#import "Locus+Config.h"
#import <UIKit/UIKit.h>
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
    // add cache
    [Locus getConfig];
    
    NSArray* classNames = [self getClassNamesFromBundle];
    
    id filter = ^int(char *className, char *selName) {
        NSString* sClass = [NSString stringWithFormat:@"%s", className];
        NSString* sSelector = [NSString stringWithFormat:@"%s", selName];
        Class klass = objc_getClass(className);

        NSDictionary* config = [Locus getConfig];
        if (config) {
            BOOL system = [[config objectForKey:LOCUS_PRINT_SYSTEM_CLASS] boolValue];
            BOOL custom = [[config objectForKey:LOCUS_PRINT_CUSTOM_CLASS] boolValue];
            BOOL super_methods = [[config objectForKey:LOCUS_PRINT_SUPER_METHODS] boolValue];
            BOOL args = [[config objectForKey:LOCUS_PRINT_ARGS] boolValue];

            int result  = 0;
            if (!system && !custom) {
                return 0;
            } else if (system && custom) {
                result = 1;
            } else {
                if (system) {
                    result = ![classNames containsObject:sClass];
                } else {
                    result = [classNames containsObject:sClass];
                }
            }
            
            if (result == 0) {
                return 0;
            }

            if (!super_methods) {
                result = reality(klass, NSSelectorFromString(sSelector));
                if (result == 0) {
                    return 0;
                }
            }

            if (args) {
                result = 2;
            } else {
                result = 1;
            }
            return result;
        } else {
            if ([classNames containsObject:sClass]
                && reality(klass, NSSelectorFromString(sSelector))){
                return 2;
            }
            return 0;
        }
    };
    filerBlockHolder = filter;
    lcs_start(filerBlockHolder);
}

+ (void)stopPrint
{
    lcs_stop_print();
}

+ (void)resumePrint
{
    lcs_resume_print();
}

static UIView* _locusView = nil;
static UIPanGestureRecognizer* _gesture = nil;
static double _viewWidth = 95.0;
static double _viewHeight = 50.0;

+ (NSInteger)safeAreaTop
{
    NSInteger top = 0;
    if (@available(iOS 11.0, *)) {
        if ([[UIApplication sharedApplication] keyWindow].safeAreaInsets.top > 0.0) {
            top = [[UIApplication sharedApplication] keyWindow].safeAreaInsets.top;
        }
    }
    return top;
}

+ (UIPanGestureRecognizer *)gesture
{
    if (!_gesture) {
        _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    }
    
    return _gesture;
}

+ (UIView *)windowView
{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

+ (void)handlePanGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:[self windowView]];
    sender.view.center = CGPointMake(sender.view.center.x + point.x, sender.view.center.y+point.y);
    [sender setTranslation:CGPointMake(0, 0) inView:[self windowView]];
}

+ (void)showUI
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [Locus start];
    });
    
    _locusView = [[LocusView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - _viewWidth - 5, [Locus safeAreaTop], _viewWidth, _viewHeight)];
    _locusView.backgroundColor = [UIColor lightGrayColor];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_locusView];
    [_locusView addGestureRecognizer:[self gesture]];
}

+ (void)hideUI
{
    if (_locusView) {
        [_locusView removeFromSuperview];
    }
}

@end
