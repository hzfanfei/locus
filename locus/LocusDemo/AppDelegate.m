//
//  AppDelegate.m
//  locus
//
//  Created by FanFamily on 2019/1/1.
//  Copyright © 2019年 niuniu. All rights reserved.
//

#import "AppDelegate.h"
#import "locus.h"
#import <objc/runtime.h>

@interface NSBundle (DDAdditions)

- (NSArray *)getClassNames;

@end

@implementation NSBundle (DDAdditions)

-(NSArray *)getClassNames{
    NSMutableArray* classNames = [NSMutableArray array];
    unsigned int count = 0;
    const char** classes = objc_copyClassNamesForImage([[[NSBundle mainBundle] executablePath] UTF8String], &count);
    for(unsigned int i=0;i<count;i++){
        NSString* className = [NSString stringWithUTF8String:classes[i]];
        [classNames addObject:className];
    }
    return classNames;
}

@end

@interface AppDelegate ()

@property (nonatomic) id block;

@end

@implementation AppDelegate


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

static id block = nil;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray* array = [[NSBundle mainBundle] getClassNames];
    
    // global block
    id filter = ^int(char *className, char *selName) {
        NSString* sClass = [NSString stringWithFormat:@"%s", className];
        NSString* sSelector = [NSString stringWithFormat:@"%s", selName];
        Class klass = objc_getClass(className);
        if ([array containsObject:sClass]
            && reality(klass, NSSelectorFromString(sSelector))){
            return 1;
        }
        return 0;
    };
    
    static id block = nil;
    
    block = filter;
    
    lcs_start(filter);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
