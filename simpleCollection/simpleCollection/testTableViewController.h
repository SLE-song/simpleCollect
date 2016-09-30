//
//  testTableViewController.h
//  test
//
//  Created by SLE on 16/9/27.
//  Copyright © 2016年 SLE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class testTableViewController;
@protocol testTableViewControllerDelegate <NSObject>

- (void)sle_testTableViewController:(testTableViewController *)testViewController didClickCompleteButton:(NSMutableArray *)currentTitleArray normalTitleArray:(NSMutableArray *)normalTitleArray;

@end

@interface testTableViewController : UITableViewController


@property (nonatomic, weak) id<testTableViewControllerDelegate> delegate;
@end
