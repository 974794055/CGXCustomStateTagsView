//
//  ViewController.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "ViewController.h"
#import "ViewTableViewCell.h"
#import "CGXCustomStateTagsView.h"

//屏幕

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
//屏幕高
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height



///NavBar高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0f
///导航栏高度
#define kTopHeight  (kStatusBarHeight + kNavBarHeight)
///tab安全区域
#define kSafeHeight    ((kStatusBarHeight>20) ? 34.0f : 0.0f)
///导航栏安全区域
#define kNavBarSafetyZone         ((kStatusBarHeight>20) ? 44.0f : 0.0f)
#define kTabBarHeight  ((kStatusBarHeight>20) ? (49.0f+34.0f) : 49.0f)
#define kVCHeight (ScreenHeight-kTopHeight-kTabBarHeight)
#define kSafeVCHeight (kStatusBarHeight>20?(ScreenHeight-kTopHeight-34):(ScreenHeight-kTopHeight))


///颜色随机
#define APPRandomColor     [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong)  CGXCustomStateTagsView *tagsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    CGXCustomStateTagsView *tagsView1 = [[CGXCustomStateTagsView alloc] init];
    tagsView1.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), 80);
    tagsView1.backgroundColor = [UIColor whiteColor];
    tagsView1.cellType =  CGXCustomStateTagsViewAlignWithCenter;
    tagsView1.minimumLineSpacing = 10;
    tagsView1.minimumInteritemSpacing = 10;
    [self.view addSubview:tagsView1];
    tagsView1.selectStateBlock = ^(CGXCustomStateTagsModel * _Nonnull tagItem, NSInteger inter) {
        NSLog(@"%@" , tagItem.tagsStr);
    };
    
    NSMutableArray *tags = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        CGXCustomStateTagsModel *tagModel = [[ CGXCustomStateTagsModel alloc] init];
        tagModel.tagsStr = @"支付";
        tagModel.tagsWidth = 40;
        tagModel.tagsImg = @"guanqi";
        tagModel.isAdaptiveWidth = YES;
        tagModel.stateType = TagsModelTypeAll;
        tagModel.tagsBorderWidth = 1;
        tagModel.tagsCornerRadius = 8;
        if (i == 0) {
            tagModel.btnType = TagsModelBtnTypeTop;
        } else if (i==1){
            tagModel.btnType = TagsModelBtnTypeBottom;
        } else if (i==2){
            tagModel.tagsWidth = 70;
            tagModel.btnType = TagsModelBtnTypeLeft;
            tagModel.tagsMarginTop = 5;
            tagModel.tagsMarginBottom = 5;
        } else if (i==3){
            tagModel.tagsWidth = 70;
            tagModel.btnType = TagsModelBtnTypeRight;
            tagModel.tagsMarginTop = 5;
            tagModel.tagsMarginBottom = 5;
        } else if (i==4){
                   tagModel.tagsWidth = 40;
                   tagModel.stateType = TagsModelTypeImage;
                   tagModel.tagsMarginTop = 5;
                   tagModel.tagsMarginBottom = 5;
               }
        [tags addObject:tagModel];
    }
    [tagsView1 updateWithTagsArray:tags];
    
    CGXCustomStateTagsView *tagsView2 = [[CGXCustomStateTagsView alloc] init];
    tagsView2.frame = CGRectMake(0,CGRectGetMaxY(tagsView1.frame)+10, CGRectGetWidth(self.view.frame), 50);
    tagsView2.backgroundColor = [UIColor whiteColor];
    tagsView2.cellType =  CGXCustomStateTagsViewAlignWithRight;
    tagsView2.minimumLineSpacing = 10;
    tagsView2.minimumInteritemSpacing = 10;
    [self.view addSubview:tagsView2];
    tagsView2.selectStateBlock = ^(CGXCustomStateTagsModel * _Nonnull tagItem, NSInteger inter) {
        NSLog(@"%@" , tagItem.tagsStr);
    };
    
    NSMutableArray *tagsArr= [NSMutableArray arrayWithObjects:@"启用",@"修改价格",@"库存", nil];
    NSMutableArray *tags11 = [NSMutableArray array];
    for (int i = 0; i<tagsArr.count; i++) {
        CGXCustomStateTagsModel *tagModel = [[ CGXCustomStateTagsModel alloc] init];
        tagModel.tagsStr = tagsArr[i];
        //        tagModel.tagsWidth = 50;
        //        tagModel.isAdaptiveWidth = NO;
        tagModel.stateType = TagsModelTypeTitle;
        //        tagModel.tagsBgColor = APPRandomColor;
        tagModel.tagsBorderColor = APPRandomColor;
        tagModel.tagsBorderWidth = 1;
        tagModel.tagsCornerRadius = 15;
        tagModel.tagsIncrement = 30;
        [tags11 addObject:tagModel];
    }
    [tagsView2 updateWithTagsArray:tags11];
    
    
    [self initializeViews];
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(tagsView2.frame), self.view.frame.size.width, ScreenHeight-kTopHeight-kTabBarHeight-CGRectGetMaxY(tagsView2.frame));
}


- (void)initializeViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollsToTop = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[self preferredCellClass] forCellReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_tableView];
}
- (Class)preferredCellClass {
    return ViewTableViewCell.class;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.缓存中取
    ViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewTableViewCell"];
    // 2.创建
    if (cell == nil) {
        cell = [[ViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ViewTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell updateModel];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}


@end
