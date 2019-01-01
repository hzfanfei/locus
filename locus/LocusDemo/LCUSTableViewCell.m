//
//  LCUSTableViewCell.m
//  locus
//
//  Created by FanFamily on 2019/1/1.
//  Copyright © 2019年 niuniu. All rights reserved.
//

#import "LCUSTableViewCell.h"

@implementation LCUSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)decorate
{
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    
    [self.textLabel setTextColor:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:0.8]];
}

@end
