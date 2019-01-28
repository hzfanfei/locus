//
//  LCUSViewController.m
//  locus
//
//  Created by FanFamily on 2019/1/1.
//  Copyright © 2019年 niuniu. All rights reserved.
//

#import "LCUSViewController.h"
#import "LCUSTableView.h"
#import "LCUSTableViewCell.h"
#import "locus.h"

static NSString* kLCUSTableViewCellIdentifier = @"kLCUSTableViewCellIdentifier";

@interface LCUSViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) LCUSTableView* tableView;
@property (nonatomic) BOOL isShowLocus;

@end

@implementation LCUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[LCUSTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LCUSTableViewCell class] forCellReuseIdentifier:kLCUSTableViewCellIdentifier];
    [self.view addSubview:self.tableView];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCUSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kLCUSTableViewCellIdentifier forIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"locus ~~ %ld", indexPath.row + 1]];
    
    [cell decorate];
    
    return cell;
}

#pragma marks
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (self.isShowLocus) {
        [Locus hideUI];
        self.isShowLocus = NO;
    } else {
        [Locus showUI];
        self.isShowLocus = YES;
    }
    return;
}

@end
