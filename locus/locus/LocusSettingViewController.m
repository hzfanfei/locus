//
//  LocusSettingViewController.m
//  locus
//
//  Created by Family Fan on 2019/1/28.
//  Copyright © 2019 niuniu. All rights reserved.
//

#import "LocusSettingViewController.h"
#import "Locus+Config.h"

static NSString* kLocusSettingTableViewCellIdentifier = @"kLocusSettingTableViewCellIdentifier";

@interface LocusSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView* tableView;
@property (nonatomic) NSMutableDictionary* switchJson;
@property (nonatomic) NSArray* switchList;

@end

@implementation LocusSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.switchList = @[@"print system class", @"print custom class", @"print super methods", @"print args"];
    
    NSDictionary* switchJson = [Locus getConfig];
    if (switchJson) {
        self.switchJson = [switchJson mutableCopy];
    } else {
        self.switchJson = [@{@"print system class": @NO, @"print custom class": @YES, @"print super methods": @NO, @"print args": @YES} mutableCopy];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLocusSettingTableViewCellIdentifier];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Default" style:UIBarButtonItemStyleDone target:self action:@selector(defaultConfig)];
}

- (void)back
{
    [Locus setConfig:self.switchJson];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)defaultConfig
{
    self.switchJson = [@{@"print system class": @NO, @"print custom class": @YES, @"print super methods": @NO, @"print args": @YES} mutableCopy];
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kLocusSettingTableViewCellIdentifier forIndexPath:indexPath];
    NSString* title = [self.switchList objectAtIndex:indexPath.row];
    if ([[self.switchJson objectForKey:title] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [cell.textLabel setText:[self.switchList objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UIAccessibilityTraitNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.switchJson setObject:@YES forKey:cell.textLabel.text];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.switchJson setObject:@NO forKey:cell.textLabel.text];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.switchList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
