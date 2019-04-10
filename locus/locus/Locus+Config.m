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
        return [config_cache copy];
    }
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:@"locus"];
    config_cache = [defaults objectForKey:@"config"];
    if (config_cache == nil) {
        config_cache = @{};
    }
    id result = (NSDictionary *)[defaults objectForKey:@"config"];
    return result;
}

+ (void)setConfig:(NSDictionary *)config
{
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:@"locus"];
    [defaults setObject:config forKey:@"config"];
    config_cache = config;
    [defaults synchronize];
}

@end
