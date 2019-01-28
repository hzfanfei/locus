//
//  LocusView.m
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "LocusView.h"
#import "LocusSettingViewController.h"

@interface LocusView ()

@property (nonatomic) UIButton* recordButton;
@property (nonatomic) UIButton* settingButton;
@property (nonatomic) BOOL isRecording;

@end

@implementation LocusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.recordButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, (frame.size.width - 15)/2, frame.size.height - 10)];
        self.recordButton.backgroundColor = [UIColor redColor];
        self.settingButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 5 - (frame.size.width - 15)/2, 5, (frame.size.width - 15)/2, frame.size.height - 10)];
        self.settingButton.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.recordButton];
        [self addSubview:self.settingButton];
        
        [self.recordButton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
        [self.settingButton addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)record:(id)sender
{
    if (self.isRecording) {
        self.recordButton.backgroundColor = [UIColor redColor];
        self.isRecording = NO;
    } else {
        self.recordButton.backgroundColor = [UIColor blueColor];
        self.isRecording = YES;
    }
}

- (void)setting:(id)sender
{
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:[LocusSettingViewController new]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navController animated:YES completion:^{
        
    }];
}

@end
