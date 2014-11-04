//
//  ViewController.h
//  FreshTableView
//
//  Created by Dong on 14-10-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"

@interface ViewController : UIViewController<PullingRefreshTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSNumber *pageSizeNum;    //下拉刷新
    NSNumber *pageIndexNum;
    NSInteger pageIndex;
    NSInteger pageSize;
    NSInteger index_num;
    NSInteger select_num;     //下拉刷新

}

@property(nonatomic) BOOL                             refreshing;    //下拉刷新
@property(nonatomic,strong) NSMutableArray           *tableArray;
@property(nonatomic,retain) NSArray                  *dataRecordArr;
@property(nonatomic,retain) PullingRefreshTableView  *tableview;

@end

