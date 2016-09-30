//
//  ViewController.m
//  simpleCollection
//
//  Created by SLE on 16/9/30.
//  Copyright © 2016年 宋帅超. All rights reserved.

/**
 * 可以随意移动任一组内  cell  位置
 * 可以删除任意组内 cell 直接添加到另一组
 * 点击取消，操作无效
 * 点击完成，操作执行
 * 可以改变组内任意 cell 位置
 */


//

#import "ViewController.h"

#import "testTableViewController.h"

@interface ViewController ()<testTableViewControllerDelegate>

// 本地化工具
@property (nonatomic, strong) NSMutableArray *currentTitleArray;
@property (nonatomic, strong) NSMutableArray *normalTitleArray;
@property (nonatomic, strong) NSUserDefaults *userDefault;

// 第一次使用APP，默认显示的按钮
@property (nonatomic, assign) int firstIn;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化本地数据
    _userDefault = [NSUserDefaults standardUserDefaults];
    _firstIn = [[_userDefault objectForKey:@"firstIn"] intValue];
    _normalTitleArray  = [_userDefault objectForKey:@"normalTitleArray"];
    _currentTitleArray = [_userDefault objectForKey:@"currentTitleArray"];
    
    // 添加顶部视图
    [self sle_setupTitleView];
    
}

- (void)sle_setupTitleView
{
    // 添加按钮父控件
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44);
    titleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleView];
    
    // 添加按钮
    if (_firstIn == 0) {// 默认显示的按钮
        
        NSArray *tmpArray = @[@"第1个",@"第2个",@"第3个",@"第4个",@"第5个"];
        NSMutableArray *otA = [NSMutableArray arrayWithObjects:@"第6个",@"第7个",@"第8个", nil];
        
        _currentTitleArray = otA;
        
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        CGFloat buttonW = titleView.frame.size.width / tmpArray.count;
        CGFloat buttonH = titleView.frame.size.height;
        
        NSMutableArray *tmp = [NSMutableArray array];
        
        for (int i =0; i < tmpArray.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonX = buttonW * i;
            [button setTitle:tmpArray[i] forState:UIControlStateNormal];
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            [titleView addSubview:button];
            
            [tmp addObject:tmpArray[i]];
        }
        
        _firstIn = 1;
        _normalTitleArray = tmp;
        [_userDefault setObject:@(_firstIn) forKey:@"firstIn"];
        [_userDefault setObject:_normalTitleArray forKey:@"normalTitleArray"];
        [_userDefault setObject:_currentTitleArray forKey:@"currentTitleArray"];
        [_userDefault synchronize];
        
        
    }else{
        
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        CGFloat buttonW = titleView.frame.size.width / _normalTitleArray.count;
        CGFloat buttonH = titleView.frame.size.height;
        
        for (int i =0; i < _normalTitleArray.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonX = buttonW * i;
            [button setTitle:_normalTitleArray[i] forState:UIControlStateNormal];
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            [titleView addSubview:button];
        }
        
        
    }
    
    
}


// 弹出测试控制器
- (IBAction)test:(id)sender {
    
    testTableViewController *tsV = [[testTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tsV.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tsV];
    [self presentViewController:nav animated:NO completion:nil];
}



#pragma mark-----<testTableViewControllerDelegate>
- (void)sle_testTableViewController:(testTableViewController *)testViewController didClickCompleteButton:(NSMutableArray *)currentTitleArray normalTitleArray:(NSMutableArray *)normalTitleArray
{
    
    self.normalTitleArray = normalTitleArray;
    [self sle_setupTitleView];
    
}


@end
