//
//  CGXCustomStateTagsView.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsView.h"
#import "CGXCustomStateTagsAlignFlowLayout.h"
#import "CGXCustomStateTagsCell.h"
@interface  CGXCustomStateTagsView()

@property (nonatomic , strong,readwrite) NSMutableArray< CGXCustomStateTagsModel *> *dataArray;//数据源数组

@end
@implementation  CGXCustomStateTagsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (CGXCustomStateTagsAlignFlowLayout *)layout
{
    CGXCustomStateTagsAlignFlowLayout*flowLayout= [[ CGXCustomStateTagsAlignFlowLayout alloc] init];
    flowLayout.betweenOfCell = self.minimumInteritemSpacing;
    switch (self.cellType) {
        case  CGXCustomStateTagsViewAlignWithLeft:
        {
            flowLayout.cellType =  CGXCustomStateTagsAlignFlowLayoutAlignWithLeft;
        }
            break;
        case  CGXCustomStateTagsViewAlignWithCenter:
        {
            flowLayout.cellType =  CGXCustomStateTagsAlignFlowLayoutAlignWithCenter;
        }
            break;
        case  CGXCustomStateTagsViewAlignWithRight:
        {
            flowLayout.cellType =  CGXCustomStateTagsAlignFlowLayoutAlignWithRight;
        }
            break;
        default:
            break;
    }
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}
- (void)initializeViews
{
    self.cellType =  CGXCustomStateTagsAlignFlowLayoutAlignWithCenter;
    self.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self layout]];
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
    [self.collectionView reloadData];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrame];
    [self.collectionView reloadData];
}
- (void)updateFrame
{
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *yellowViewTop = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraint:yellowViewTop];
    
    NSLayoutConstraint *yellowViewLeft = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [self addConstraint:yellowViewLeft];
    
    NSLayoutConstraint *yellowViewRight = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self addConstraint:yellowViewRight];
    
    NSLayoutConstraint *yellowViewBottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraint:yellowViewBottom];
}
- (void)setCellType:( CGXCustomStateTagsViewAlignType)cellType
{
    _cellType = cellType;
    [self updateLayout];
}
- (void)setInset:(UIEdgeInsets)inset
{
    _inset = inset;
    [self updateLayout];
}
- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing
{
    _minimumLineSpacing =  minimumLineSpacing;
    [self updateLayout];
}
- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    _minimumInteritemSpacing = minimumInteritemSpacing;
    [self updateLayout];
}
- (void)updateLayout
{
    self.collectionView.collectionViewLayout = [self layout];;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
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
            self.selectStateBlock(model,indexPath.row);
        }
}

- (void)updateWithTagsArray:(NSMutableArray *)array
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.collectionView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
