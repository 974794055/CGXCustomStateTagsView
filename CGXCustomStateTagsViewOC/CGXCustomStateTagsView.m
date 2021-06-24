//
//  CGXCustomStateTagsView.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsView.h"
#import "CGXCustomStateTagsLayout.h"
#import "CGXCustomStateTagsCell.h"
#import "CGXCustomStateTagsPopView.h"
@interface  CGXCustomStateTagsView()<UIGestureRecognizerDelegate>
@property (nonatomic , strong,readwrite) UICollectionView *collectionView;
@property (nonatomic , strong) CGXCustomStateTagsLayout*flowLayout;
@property (nonatomic , strong,readwrite) NSMutableArray< CGXCustomStateTagsModel *> *dataArray;//数据源数组
@property (nonatomic , strong) UIButton *moreBtn;

@property (nonatomic , strong) UIView *alertView;

//cell对齐方式
@property (nonatomic,assign) CGXCustomStateTagsViewAlignType cellType;

@end

@implementation  CGXCustomStateTagsView

/**
   初始化方式
*/
- (instancetype)initWithType:(CGXCustomStateTagsViewAlignType)type
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.cellType = type;
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.indicatorRound = 10;
    self.indicatorWidth = 10;
    self.indicatorHeight = 15;
    self.fillColor = [UIColor whiteColor];
    self.indicatorborderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    self.indicatorborderWidth = 0.5;
    self.moreFont = [UIFont systemFontOfSize:14];
    self.moreColor = [UIColor blackColor];
    self.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.flowLayout= [[ CGXCustomStateTagsLayout alloc] init];
    switch (self.cellType) {
        case  CGXCustomStateTagsViewAlignWithLeft:
        {
            self.flowLayout.cellType =  CGXCustomStateTagsLayoutAlignWithLeft;
        }
            break;
        case  CGXCustomStateTagsViewAlignWithRight:
        {
            self.flowLayout.cellType =  CGXCustomStateTagsLayoutAlignWithRight;
        }
            break;
        default:
            break;
    }
    self.flowLayout.moreWidth = 60;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator =NO;
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.scrollEnabled  =NO;
    _collectionView.backgroundColor =self.backgroundColor;
    [_collectionView registerClass:[ CGXCustomStateTagsCell class] forCellWithReuseIdentifier:NSStringFromClass([ CGXCustomStateTagsCell class])];
    [self addSubview:_collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:self.moreColor forState:UIControlStateNormal];
    [self.moreBtn.titleLabel setFont:self.moreFont];
    [self.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreBtn];
    [self bringSubviewToFront:self.moreBtn];
    self.moreBtn.hidden = YES;
        [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.bounds.size.width == 0 || self.bounds.size.height == 0) {
        return;
    }
    [self.collectionView setNeedsLayout];
    [self.collectionView layoutSubviews];
    CGRect targetFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.collectionView.frame = targetFrame;
    if (!CGRectEqualToRect(self.collectionView.frame, targetFrame)) {
        self.collectionView.frame = targetFrame;
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
    [self.collectionView setNeedsLayout];
    [self.collectionView layoutSubviews];
    
    self.moreBtn.hidden = YES;
    self.collectionView.collectionViewLayout = self.flowLayout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    if (self.flowLayout.hiddenArray.count>0) {
        self.moreBtn.hidden = NO;
        if(self.cellType == CGXCustomStateTagsViewAlignWithRight) {
            self.moreBtn.frame = CGRectMake(0, 0, 80, CGRectGetHeight(self.bounds));
        } else{
            self.moreBtn.frame = CGRectMake(CGRectGetWidth(self.bounds)-80, 0, 80, CGRectGetHeight(self.bounds));
        }
    }
}
- (void)setMoreFont:(UIFont *)moreFont
{
    moreFont = moreFont;
    [self.moreBtn.titleLabel setFont:moreFont];
}
- (void)setMoreColor:(UIColor *)moreColor
{
    _moreColor = moreColor;
    [self.moreBtn setTitleColor:moreColor forState:UIControlStateNormal];
}
- (NSMutableArray< CGXCustomStateTagsModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark - 返回每个分区的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.inset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float height = CGRectGetHeight(collectionView.frame)-self.inset.top-self.inset.bottom;
    CGXCustomStateTagsModel *model = self.dataArray[indexPath.row];
    if (model.isAdaptiveWidth) {
        NSDictionary *dic = @{NSFontAttributeName:model.tagsFont};
        CGSize strSize = [model.tagsStr boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.collectionView.frame),MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        if (model.stateType == TagsModelTypeTitle) {
            return CGSizeMake(ceil(strSize.width) + model.tagsIncrement,height);
        } else if (model.stateType == TagsModelTypeImage){
            return CGSizeMake(model.tagsImgSize.width + model.tagsIncrement,height);
        } else{
            if (model.btnType == TagsModelBtnTypeTop || model.btnType == TagsModelBtnTypeBottom) {
                return CGSizeMake(ceil(strSize.width) + model.tagsMarginTop+model.tagsMarginBottom+ model.tagsIncrement,height);
            } else {
                return CGSizeMake(ceil(strSize.width) + model.tagsImgSize.width + model.tagsSpace+model.tagsIncrement +model.tagsMarginTop+model.tagsMarginBottom,height);
            }
            
        }
    } else{
        return CGSizeMake(model.tagsWidth,height);
    }
}
#pragma mark - cell的显示处理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXCustomStateTagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ CGXCustomStateTagsCell class]) forIndexPath:indexPath];
    CGXCustomStateTagsModel *model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    return cell;
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXCustomStateTagsModel *model = self.dataArray[indexPath.row];
    if (self.selectStateBlock) {
        self.selectStateBlock(model);
    }
}
- (void)moreBtnClick:(UIButton *)btn
{
    NSMutableArray *interArr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in self.flowLayout.hiddenArray) {
        [interArr addObject:@(attributes.indexPath.row)];
    }
    NSMutableArray *hiddenArr = [NSMutableArray array];
    for (int i = 0; i<self.dataArray.count; i++) {
        CGXCustomStateTagsModel *model = self.dataArray[i];
        if ([interArr containsObject:[NSNumber numberWithInt:i]]) {
            [hiddenArr addObject:model];
        }
    }

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.alertView = [[UIView alloc] init];
    self.alertView.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [keyWindow addSubview:self.alertView];
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView)];
    myTap.delegate = self;
    [self.alertView addGestureRecognizer:myTap];
    
    CGRect rect = [self convertRect:self.moreBtn.frame toView:keyWindow];

    CGXCustomStateTagsPopView *popView = [[CGXCustomStateTagsPopView alloc] init];
    popView.fillColor = [UIColor whiteColor];
    popView.indicatorWidth = self.indicatorWidth;
    popView.indicatorHeight = self.indicatorHeight;
    popView.indicatorRound = self.indicatorRound;
    popView.indicatorborderColor = self.indicatorborderColor;
    popView.indicatorborderWidth = self.indicatorborderWidth;
    [self.alertView addSubview:popView];
    
    ///NavBar高度
    CGFloat kStatusHeight  = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat kTabHeight  = kStatusHeight > 20 ? 83:49;
    CGFloat round = popView.indicatorRound;
    CGFloat popHeight = round + 40 * hiddenArr.count;
    CGFloat popWidth = 100;
    
    CGFloat spaceeeeee = rect.origin.y + popHeight + CGRectGetHeight(self.moreBtn.frame)/2.0+15;
    if (self.cellType == CGXCustomStateTagsViewAlignWithRight) {
        if (spaceeeeee > [UIScreen mainScreen].bounds.size.height-kTabHeight) {
            popView.type = ShowViewTypeBottomLeft;
            popView.frame = CGRectMake(rect.size.width/2.0-round-popView.indicatorWidth,rect.origin.y-popHeight+15, popWidth, popHeight);
        } else{
            popView.type = ShowViewTypeTopLeft;
            popView.frame = CGRectMake(rect.size.width/2.0-round-popView.indicatorWidth,rect.origin.y+CGRectGetHeight(self.moreBtn.frame)/2.0+15, popWidth, popHeight);
        }
    } else{
        if (spaceeeeee > [UIScreen mainScreen].bounds.size.height-kTabHeight) {
            popView.type = ShowViewTypeBottomRight;
            popView.frame = CGRectMake(CGRectGetWidth(self.frame)-popWidth-(CGRectGetWidth(self.moreBtn.frame)/2.0-round-popView.indicatorWidth),rect.origin.y-popHeight+15, popWidth, popHeight);
        } else{
            popView.type = ShowViewTypeTopRight;
            popView.frame = CGRectMake(CGRectGetWidth(self.frame)-popWidth-(CGRectGetWidth(self.moreBtn.frame)/2.0-round-popView.indicatorWidth),rect.origin.y+CGRectGetHeight(self.moreBtn.frame)/2.0+15, popWidth, popHeight);
        }
    }

    __weak typeof(self) weakSelf = self;
    [popView updateWithTagsArray:hiddenArr SeectBlock:^(CGXCustomStateTagsModel * _Nonnull tagItem) {
        if (weakSelf.selectStateBlock) {
            weakSelf.selectStateBlock(tagItem);
        }
        [weakSelf didTapBackgroundView];
    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.alertView){
        return YES;
    }
    return NO;
}
- (void)didTapBackgroundView
{
    [self.alertView removeFromSuperview];
}
- (void)updateWithTagsArray:(NSMutableArray *)array
{
    [self.dataArray removeAllObjects];
    if(self.cellType == CGXCustomStateTagsViewAlignWithRight) {
        self.dataArray = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    }else{
        [self.dataArray addObjectsFromArray:array];
    }
    [self.collectionView reloadData];
    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
