//
//  testTableViewController.m
//  test
//
//  Created by sle on 16/9/27.
//  Copyright © 2016年 SLE. All rights reserved.
//

#import "testTableViewController.h"




@interface testTableViewController ()

@property (nonatomic, strong) NSMutableArray *currentTitleArray;
@property (nonatomic, strong) NSMutableArray *normalTitleArray;
@property (nonatomic, strong) NSUserDefaults *userDefault;

@end

@implementation testTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sle_setupArray];
    self.tableView.editing =YES;
    [self sle_setupTopNavBarButtonItem];
}


- (void)sle_setupArray
{
    _userDefault = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [_userDefault objectForKey:@"currentTitleArray"];
    NSMutableArray *tmp = [NSMutableArray array];
    for (int i = 0; i <array.count; i++) {
        [tmp addObject:array[i]];
    }
    _currentTitleArray = tmp;
    
    NSArray *array1 = [_userDefault objectForKey:@"normalTitleArray"];
    NSMutableArray *tmp1 = [NSMutableArray array];
    for (int i = 0; i <array1.count; i++) {
        [tmp1 addObject:array1[i]];
    }
    _normalTitleArray = tmp1;
}






- (void)sle_setupTopNavBarButtonItem
{
    
    self.navigationItem.title = @"测试测试";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:30/255.0 green:164/255.0 blue:75/255.0 alpha:1] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:30/255.0 green:164/255.0 blue:75/255.0 alpha:1] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}




- (void)completeButtonClick
{
    
    [_userDefault setObject:_normalTitleArray forKey:@"normalTitleArray"];
    [_userDefault setObject:_currentTitleArray forKey:@"currentTitleArray"];
    [_userDefault synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([_delegate respondsToSelector:@selector(sle_testTableViewController:didClickCompleteButton:normalTitleArray:)]) {
        
        [_delegate sle_testTableViewController:self didClickCompleteButton:_currentTitleArray normalTitleArray:_normalTitleArray];
        
    }
}


- (void)cancleButtonClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}








#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return _normalTitleArray.count;
        
    }else{
    
        return _currentTitleArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = _currentTitleArray[indexPath.row];
    }else if(indexPath.section == 0){
    
        cell.textLabel.text = _normalTitleArray[indexPath.row];
    }
    
    return cell;
}





- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 取出模型
        NSString *chanel = self.normalTitleArray[indexPath.row];
        [self.normalTitleArray removeObjectAtIndex:indexPath.row];
        [self.currentTitleArray addObject:chanel];
        
    }if (indexPath.section == 1) {
        
        // 取出模型
        NSString *chanel = self.currentTitleArray[indexPath.row];
        [self.currentTitleArray removeObjectAtIndex:indexPath.row];
        [self.normalTitleArray addObject:chanel];
    }
    [tableView reloadData];
    
    
    
    
}





- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

    if (sourceIndexPath.section == 0) {
        
        NSString *tmp = _normalTitleArray[sourceIndexPath.row];
        [self.normalTitleArray removeObjectAtIndex:sourceIndexPath.row];
        [_normalTitleArray insertObject:tmp atIndex:destinationIndexPath.row];
        
    }else if (sourceIndexPath.section == 1){
    
        NSString *tmp = _currentTitleArray[sourceIndexPath.row];
        [_currentTitleArray removeObjectAtIndex:sourceIndexPath.row];
        [_currentTitleArray insertObject:tmp atIndex:destinationIndexPath.row];
    }

    [tableView reloadData];
    

}


/**
 *  此方法返回的是点击编辑按钮时，左边按钮的形式
 */
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        return UITableViewCellEditingStyleDelete;
    }else{
    
        // 返回左边是加号按钮
        return UITableViewCellEditingStyleInsert;
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return @"已选";
        
    }else{
        
        return @"未选";
    }
    
    
    
}

@end
