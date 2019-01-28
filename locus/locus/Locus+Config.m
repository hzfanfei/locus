//
//  Locus+UserDefaults.m
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "Locus+Config.h"

@implementation Locus (Config)

+ (NSDictionary *)getConfig
{
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:@"locus"];
    [defaults objectForKey:@"config"];
    return (NSDictionary *)[defaults objectForKey:@"config"];
}

+ (void)setConfig:(NSDictionary *)config
{
    NSUserDefaults* defaults = [[NSUserDefaults alloc] initWithSuiteName:@"locus"];
    [defaults setObject:config forKey:@"config"];
    [defaults synchronize];
}

@end
