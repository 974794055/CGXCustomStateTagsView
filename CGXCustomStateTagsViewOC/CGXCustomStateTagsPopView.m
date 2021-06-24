//
//  CGXCustomStateTagsPopView.m
//  CGXCustomStateTagsView
//
//  Created by CGX on 2021/6/20.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsPopView.h"

@interface  CGXCustomStateTagsPopViewCell:UICollectionViewCell
@property (nonatomic , strong) UILabel *tagsLabel;
@property (nonatomic , strong) CGXCustomStateTagsModel *model;
@property (nonatomic , strong) UIView *lineView;
- (void)updateWithModel:(CGXCustomStateTagsModel *)model;
@end
@implementation  CGXCustomStateTagsPopViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagsLabel  =[[UILabel alloc] init];
        self.tagsLabel.textColor = [UIColor blackColor];
        self.tagsLabel.font = [UIFont systemFontOfSize:14];
        self.tagsLabel.numberOfLines = 1;
        self.tagsLabel.textAlignment = NSTextAlignmentLeft;
        self.tagsLabel.layer.masksToBounds = YES;
        self.tagsLabel.layer.borderWidth = 0;
        self.tagsLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        self.tagsLabel.layer.cornerRadius = 0;
        [self.contentView addSubview:self.tagsLabel];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:0.5];
        [self.contentView addSubview:self.lineView];
        [self.contentView bringSubviewToFront:self.lineView];
    }
    return self;
}
- (void)updateWithModel:( CGXCustomStateTagsModel *)model
{
    self.model = model;
    self.tagsLabel.frame = CGRectMake(10, 0, CGRectGetWidth(self.contentView.frame)-10, CGRectGetHeight(self.contentView.frame));
    self.lineView.frame = CGRectMake(5, CGRectGetHeight(self.contentView.frame)-1, CGRectGetWidth(self.contentView.frame)-5, 1);
    self.tagsLabel.text = model.tagsStr;
    self.tagsLabel.textColor = model.tagsColor;
    self.tagsLabel.font = model.tagsFont;
}
@end


@interface CGXCustomStateTagsPopView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray< CGXCustomStateTagsModel *> *dataArray;//数据源数组

@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@property (nonatomic , copy)  CGXCustomStateTagsPopViewSelectBlock selectStateBlock;
@end
@implementation CGXCustomStateTagsPopView

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
- (void)initializeViews
{
    self.dataArray = [NSMutableArray array];
    self.indicatorRound = 10;
    self.indicatorWidth = 15;
    self.indicatorHeight = 15;
    self.fillColor = [UIColor whiteColor];
    self.indicatorborderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    self.indicatorborderWidth = 1;
    _triangleLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.triangleLayer];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CGXCustomStateTagsPopViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXCustomStateTagsPopViewCell class])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    if (self.type == ShowViewTypeTopLeft || self.type == ShowViewTypeTopRight) {
        self.collectionView.frame = CGRectMake(0, self.indicatorHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.indicatorHeight);
    } else{
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.indicatorHeight);
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    self.triangleLayer.fillColor = self.fillColor.CGColor;
    self.triangleLayer.frame = self.bounds;
    
    CGFloat round = self.indicatorRound > 0 ? self.indicatorRound:10;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    switch (self.type) {
        case ShowViewTypeTopLeft:
        {
            [path moveToPoint:CGPointMake(round, self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(round+self.indicatorWidth, 0)];
            [path addLineToPoint:CGPointMake(round+self.indicatorWidth*2, self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(width-round, self.indicatorHeight)];
            [path addArcWithCenter:CGPointMake(width-round, self.indicatorHeight+round) radius:round startAngle:M_PI_2*3 endAngle:M_PI_2*4 clockwise:YES];
            [path addLineToPoint:CGPointMake(width, self.indicatorHeight+round)];
            [path addLineToPoint:CGPointMake(width, height-round)];
            [path addArcWithCenter:CGPointMake(width-round, height-round) radius:round startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(width-round, height)];
            [path addLineToPoint:CGPointMake(round, height)];
            [path addArcWithCenter:CGPointMake(round, height-round) radius:round startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(0, height-round)];
            [path addLineToPoint:CGPointMake(0, self.indicatorHeight+round)];
            [path addArcWithCenter:CGPointMake(round, self.indicatorHeight+round) radius:round startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        }
            break;
        case ShowViewTypeTopRight:
        {
            [path moveToPoint:CGPointMake(round, self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(width-round-self.indicatorWidth*2, self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(width-round-self.indicatorWidth, 0)];
            [path addLineToPoint:CGPointMake(width-round, self.indicatorHeight)];
            [path addArcWithCenter:CGPointMake(width-round, self.indicatorHeight+round) radius:round startAngle:M_PI_2*3 endAngle:M_PI_2*4 clockwise:YES];
            [path addLineToPoint:CGPointMake(width, self.indicatorHeight+round)];
            [path addLineToPoint:CGPointMake(width, height-round)];
            [path addArcWithCenter:CGPointMake(width-round, height-round) radius:round startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(width-round, height)];
            [path addLineToPoint:CGPointMake(round, height)];
            [path addArcWithCenter:CGPointMake(round, height-round) radius:round startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(0, height-round)];
            [path addLineToPoint:CGPointMake(0, self.indicatorHeight+round)];
            [path addArcWithCenter:CGPointMake(round, self.indicatorHeight+round) radius:round startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        }
            break;
        case ShowViewTypeBottomLeft:
        {
            [path moveToPoint:CGPointMake(round, 0)];
            [path addLineToPoint:CGPointMake(width-round, 0)];
            [path addArcWithCenter:CGPointMake(width-round, round) radius:round startAngle:M_PI_2*3 endAngle:M_PI*2 clockwise:YES];
            [path addLineToPoint:CGPointMake(width, round)];
            [path addLineToPoint:CGPointMake(width, height-self.indicatorHeight-round)];
            [path addArcWithCenter:CGPointMake(width-round, height-self.indicatorHeight-round) radius:round startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(width-round, height-self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(round+self.indicatorWidth*2, height-self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(round+self.indicatorWidth, height)];
            [path addLineToPoint:CGPointMake(round, height-self.indicatorHeight)];
            [path addArcWithCenter:CGPointMake(round, height-self.indicatorHeight-round) radius:round startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(0, height-self.indicatorHeight-round)];
            [path addLineToPoint:CGPointMake(0, round)];
            [path addArcWithCenter:CGPointMake(round, round) radius:round startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        }
            break;
        case ShowViewTypeBottomRight:
        {
            [path moveToPoint:CGPointMake(round, 0)];
            [path addLineToPoint:CGPointMake(width-round, 0)];
            [path addArcWithCenter:CGPointMake(width-round, round) radius:round startAngle:M_PI_2*3 endAngle:M_PI*2 clockwise:YES];
            [path addLineToPoint:CGPointMake(width, round)];
            [path addLineToPoint:CGPointMake(width, height-self.indicatorHeight-round)];
            [path addArcWithCenter:CGPointMake(width-round, height-self.indicatorHeight-round) radius:round startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(width-round, height-self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(width-round-self.indicatorWidth, height)];
            [path addLineToPoint:CGPointMake(width-round-self.indicatorWidth*2, height-self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(round, height-self.indicatorHeight)];
            [path addArcWithCenter:CGPointMake(round, height-round-self.indicatorHeight) radius:round startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(0, height-round-self.indicatorHeight)];
            [path addLineToPoint:CGPointMake(0, round)];
            [path addArcWithCenter:CGPointMake(round, round) radius:round startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        }
            break;
            
        default:
            break;
    }
    [path closePath];
    self.triangleLayer.path = path.CGPath;

    self.triangleLayer.strokeColor = self.indicatorborderColor.CGColor;

    self.triangleLayer.lineWidth = self.indicatorborderWidth;
    self.triangleLayer.lineCap = kCALineCapRound;
    self.triangleLayer.lineJoin = kCALineJoinRound;
    
    [CATransaction commit];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width,40);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXCustomStateTagsPopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXCustomStateTagsPopViewCell class]) forIndexPath:indexPath];
    CGXCustomStateTagsModel *model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    cell.lineView.hidden = (indexPath.row < self.dataArray.count-1) ? NO:YES;
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
- (void)updateWithTagsArray:(NSMutableArray<CGXCustomStateTagsModel *> *)array SeectBlock:(CGXCustomStateTagsPopViewSelectBlock)selectBlock
{
    self.selectStateBlock = selectBlock;
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
