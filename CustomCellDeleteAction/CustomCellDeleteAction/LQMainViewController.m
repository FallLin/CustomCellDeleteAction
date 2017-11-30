//
//  LQMainViewController.m
//  CustomCellDeleteAction
//
//  Created by monkey on 2017/11/29.
//  Copyright © 2017年 luqiao. All rights reserved.
//

#import "LQMainViewController.h"
#import "LQMainTableViewCell.h"

#define LQMainBGColor UIColorFromRGB(0xe5e5e5)

static NSString *kCellID = @"cellID";

@interface LQMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation LQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LQMainBGColor;
    
    [self configTableView];
}

#pragma mark - private method

- (void)configTableView {
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 50;
    _tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)showAlertWithIndexPath:(NSIndexPath *)indexPath{
    WeakObj(self);
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:@"确认删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        StrongObj(self);
        [selfStrong.dataSource removeObjectAtIndex:indexPath.row];
        [selfStrong.tableView reloadData];
    }];
    [alertCtr addAction:cancelAction];
    [alertCtr addAction:sureAction];
    [self presentViewController:alertCtr animated:YES completion:nil];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LQMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.rowLabel.text = [NSString stringWithFormat:@"%@--%@", [self class], self.dataSource[indexPath.row]];
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                         title:@"自定义删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           [self showAlertWithIndexPath:indexPath];
                                                                       }];
    rowAction.backgroundColor = LQMainBGColor;
    return @[rowAction];
}

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (@available(iOS 11.0, *)) {
//        WeakObj(self);
//        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
//                                                                             title:@"删除按钮"
//                                                                           handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//                                                                               StrongObj(self);
//                                                                               [selfStrong showAlertWithIndexPath:indexPath];
//
//                                                                               completionHandler(YES);
//                                                                           }];
//
//        action.image = [UIImage imageNamed:@"icon_delete"];
//        action.backgroundColor = LQMainBGColor;
//
//        return [UISwipeActionsConfiguration configurationWithActions:@[action]];
//    }
//    return nil;
//}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        [self customDeleteBtnAfteriOS11:tableView];
    }
}
- (void)customDeleteBtnAfteriOS11:(UITableView *)tableView {
    for (UIView *subview in tableView.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UISwipeActionPullView"]) {
//            subview.backgroundColor = [UIColor clearColor];
            
            UIButton *btn = [subview.subviews objectAtIndex:0];
            [btn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//            [btn setBackgroundColor:[UIColor clearColor]];
        }
    }
}

#pragma mark - getters

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSArray *array = @[@"壹", @"贰", @"叁", @"肆", @"伍",
                           @"陆", @"柒", @"捌", @"玖", @"拾"];
        _dataSource = [NSMutableArray arrayWithArray:array];
    }
    return _dataSource;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
