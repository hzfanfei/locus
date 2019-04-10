//
//  Locus+UserDefaults.h
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "Locus.h"

#define LOCUS_PRINT_SYSTEM_CLASS @"print system class"
#define LOCUS_PRINT_CUSTOM_CLASS @"print custom class"
#define LOCUS_PRINT_SUPER_METHODS @"print super methods"
#define LOCUS_PRINT_ARGS @"print args"

NS_ASSUME_NONNULL_BEGIN

@interface Locus (Config)

+ (NSMutableDictionary *)getConfig;
+ (void)setConfig:(NSMutableDictionary *)config;

@end

NS_ASSUME_NONNULL_END
