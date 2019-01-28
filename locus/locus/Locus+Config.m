//
//  Locus+UserDefaults.m
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "Locus+Config.h"

static NSDictionary* config_cache = nil;

@implementation Locus (Config)

+ (NSDictionary *)getConfig
{
    if (config_cache) {
        return config_cache;
    }
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:@"locus"];
    config_cache = [defaults objectForKey:@"config"];
    return (NSDictionary *)[defaults objectForKey:@"config"];
}

+ (void)setConfig:(NSDictionary *)config
{
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:@"locus"];
    [defaults setObject:config forKey:@"config"];
    config_cache = config;
    [defaults synchronize];
}

@end
