//
//  LocusView.m
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "LocusView.h"
#import "Locus.h"
#import "LocusSettingViewController.h"
#import "LocusRes.h"

@interface LocusView ()

@property (nonatomic) UILabel* titleLabel;
@property (nonatomic) UIButton* closeButton;
@property (nonatomic) UIButton* recordButton;
@property (nonatomic) UIButton* settingButton;
@property (nonatomic) BOOL isRecording;

@end

@implementation LocusView

- (UIImage *)imageWithBase64String:(NSString *)base64
{
    NSData* data = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 1, 1)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:8]];
        [self.titleLabel setText:@"Locus"];
        [self.titleLabel sizeToFit];
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 5 - 8, 5, 8, 8)];
        self.closeButton.titleLabel.font = [UIFont systemFontOfSize:8];
        [self.closeButton setTitle:@"x" forState:UIControlStateNormal];
        [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.recordButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5 + 13, 20, 20)];
        [self.recordButton setImage:[self imageWithBase64String:LocusIconRecordStart] forState:UIControlStateNormal];
        self.settingButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 5 - (frame.size.width - 15)/2, 5 + 13, 20, 20)];
        [self.settingButton setImage:[self imageWithBase64String:LocusIconSetting] forState:UIControlStateNormal];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.closeButton];
        [self addSubview:self.recordButton];
        [self addSubview:self.settingButton];
        
        [self.closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self.recordButton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
        [self.settingButton addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)stopPrint
{
    [self.recordButton setImage:[self imageWithBase64String:LocusIconRecordStart] forState:UIControlStateNormal];
    [Locus stopPrint];
    self.isRecording = NO;
}

- (void)resumePrint
{
    [self.recordButton setImage:[self imageWithBase64String:LocusIconRecordEnd] forState:UIControlStateNormal];
    [Locus resumePrint];
    self.isRecording = YES;
}

- (void)record:(id)sender
{
    if (self.isRecording) {
        [self stopPrint];
    } else {
        [self resumePrint];
    }
}

- (void)setting:(id)sender
{
    [self stopPrint];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:[LocusSettingViewController new]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)close:(id)sender
{
    [self stopPrint];
    [Locus hideUI];
}




@end
