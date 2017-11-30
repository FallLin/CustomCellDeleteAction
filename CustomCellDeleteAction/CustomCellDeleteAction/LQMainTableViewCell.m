//
//  LQMainTableViewCell.m
//  CustomCellDeleteAction
//
//  Created by monkey on 2017/11/29.
//  Copyright © 2017年 luqiao. All rights reserved.
//

#import "LQMainTableViewCell.h"

@implementation LQMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    [super didTransitionToState:state];
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
        NSLog(@"%@", self.subviews);
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
                subview.backgroundColor = [UIColor clearColor];

                UIButton *btn = [subview.subviews objectAtIndex:0];
                [btn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
                [btn setTitle:nil forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
