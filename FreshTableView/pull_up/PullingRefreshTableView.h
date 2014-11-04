//
//  PullingRefreshTableView.h
//  PullingTableView
//
//  Created by danal on 3/6/12.If you want use it,please leave my name here
//  Copyright (c) 2012 danal Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kPRStateNormal = 0,   // header footer part appeared
    kPRStatePulling = 1,  // header footer totally appeared
    kPRStateLoading = 2,  // 加载数据 请求中
    kPRStateHitTheEnd = 3 //
} PRState;

#pragma mark - LoadingView
@interface LoadingView : UIView {
    
    UILabel *_stateLabel;                       // 上下拉提示
    UILabel *_dateLabel;                        // 时间的提示
    UIImageView *_arrowView;                    // 旋转的图片
    UIActivityIndicatorView *_activityView;     //
    CALayer *_arrow;                            // 旋转的图层
    BOOL _loading;                              // 是否在加载数据中
}

@property (nonatomic,getter = isLoading) BOOL loading;  // 是否在加载数据中
@property (nonatomic,getter = isAtTop)   BOOL atTop;    // 是否在顶部
@property (nonatomic) PRState state;                    // tableView 当前的状态

- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top;       
- (void)updateRefreshDate:(NSDate *)date;


@end


#pragma mark - PullingRefreshTableView
@protocol PullingRefreshTableViewDelegate;

@interface PullingRefreshTableView : UITableView <UIScrollViewDelegate>{
    LoadingView *_headerView;
    LoadingView *_footerView;
    UILabel *_msgLabel;
    BOOL _loading;
    BOOL _isFooterInAction;
    NSInteger _bottomRow;
}


@property (nonatomic,assign) id <PullingRefreshTableViewDelegate> pullingDelegate;
@property (nonatomic) BOOL autoScrollToNextPage;
@property (nonatomic) BOOL reachedTheEnd;
@property (nonatomic,getter = isHeaderOnly) BOOL headerOnly;


- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<PullingRefreshTableViewDelegate>)aPullingDelegate;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;          //tableview拖动中
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;     //tableview拖动结束
- (void)tableViewDidFinishedLoading;                            //
- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg; //
- (void)launchRefreshing;

@end


@protocol PullingRefreshTableViewDelegate <NSObject>

@required

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView;

@optional

//Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView;

//Implement the follows to set date you want,Or Ignore them to use current date
- (NSDate *)pullingTableViewRefreshingFinishedDate;
- (NSDate *)pullingTableViewLoadingFinishedDate;

@end



//Usage example
/*
 _tableView = [[PullingRefreshTableView alloc] initWithFrame:frame pullingDelegate:aPullingDelegate];
 [self.view addSubview:_tableView];
 _tableView.autoScrollToNextPage = NO;
 _tableView.delegate = self;
 _tableView.dataSource = self;
 */


