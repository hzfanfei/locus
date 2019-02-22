//
//  Locus.h
//  locus
//
//  Created by FanFamily on 2019/1/26.
//  Copyright © 2019年 niuniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "locusImpl.h"

NS_ASSUME_NONNULL_BEGIN

@interface Locus : NSObject

+ (void)start;

+ (void)stopPrint;

+ (void)resumePrint;

+ (void)showUI;

+ (void)hideUI;

// performance start
+ (void)startTestPerformance:(long)ms;

@end

NS_ASSUME_NONNULL_END
