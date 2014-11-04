//
//  ViewController.m
//  FreshTableView
//
//  Created by Dong on 14-10-30.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize refreshing=_refreshing;
@synthesize tableArray=_tableArray;
@synthesize dataRecordArr=_dataRecordArr;
@synthesize tableview=_tableview;

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化  下载下拉刷新数据
    self.refreshing   = YES;
    pageSize     = 10;
    pageIndex    = 1;
    pageSizeNum  = [NSNumber numberWithInt:10];
    pageIndexNum = [NSNumber numberWithInt:1];
    
    self.tableArray=[[NSMutableArray alloc]init];
    [self.tableArray addObject:@"1"];
    [self.tableArray addObject:@"1"];
    [self.tableArray addObject:@"1"];
    [self.tableArray addObject:@"1"];

    [self initTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)initTableView{
    
    CGRect tableFrame =CGRectMake(0, 60, 320, 300);
    _tableview = [[PullingRefreshTableView alloc] initWithFrame:tableFrame pullingDelegate:self];
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableview.backgroundColor=[UIColor redColor];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    
}
#pragma mark -
#pragma mark -- pull-down

- (void)loadData
{
    //数据 报错  bug
    if (self.refreshing) {
        self.refreshing = NO;
    }
    if (_tableArray.count == 0)
    {
        [self.tableview tableViewDidFinishedLoadingWithMessage:@"暂无信息！"];
        self.tableview = nil;
        
    }else if (self.dataRecordArr.count < pageIndex) {    //如果请求的数据count小于当前的页数就代表数据请求完毕
        
        [self.tableview tableViewDidFinishedLoadingWithMessage:@"全部加载!"];
        self.tableview.reachedTheEnd  = YES;
        
    } else {
        
        self.tableview.reachedTheEnd  = NO;
        [self.tableview tableViewDidFinishedLoading];
    }
    [self.tableview reloadData];

    
}

#pragma  mark -
#pragma  mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
   
    self.refreshing = YES;
    
    if (self.tableArray) {
        [self.tableArray removeAllObjects];
    }

    [self.tableArray addObject:@"1"];
    [self.tableArray addObject:@"1"];

    [self performSelector:@selector(loadData) withObject:nil afterDelay:3.f];
}


- (NSDate *)pullingTableViewRefreshingFinishedDate
{
    NSDate *_date = [NSDate date];
    return _date;
}


- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    self.refreshing = YES;

    [self.tableArray addObject:@"1"];
    [self.tableArray addObject:@"1"];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:3.f];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"scrollView.contentSize=%f",scrollView.contentSize.height);
//    NSLog(@"scrollView.contentOffset=%f",scrollView.contentOffset.y);
//    NSLog(@"scrollView.contentInset=%f",scrollView.contentInset.top);

    [_tableview tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_tableview tableViewDidEndDragging:scrollView];
}






#pragma mark -- UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//   
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELLID = @"cellid";
    
    UITableViewCell* cell= (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CELLID];
    if (cell == nil){
        cell=[[UITableViewCell alloc]init];//zkq
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%d",(int )indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
