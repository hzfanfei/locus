//
//  Locus+UserDefaults.h
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "Locus.h"

NS_ASSUME_NONNULL_BEGIN

@interface Locus (Config)

+ (NSDictionary *)getConfig;
+ (void)setConfig:(NSDictionary *)config;

@end

NS_ASSUME_NONNULL_END
