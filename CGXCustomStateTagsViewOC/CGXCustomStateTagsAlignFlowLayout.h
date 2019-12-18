//
//  UICollectionViewCellSpaceRightFlowLayout.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CGXCustomStateTagsAlignFlowLayoutAlignType){
     CGXCustomStateTagsAlignFlowLayoutAlignWithLeft,
     CGXCustomStateTagsAlignFlowLayoutAlignWithCenter,
     CGXCustomStateTagsAlignFlowLayoutAlignWithRight
};
@interface  CGXCustomStateTagsAlignFlowLayout : UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign) CGXCustomStateTagsAlignFlowLayoutAlignType cellType;

-(instancetype)initWthType : (CGXCustomStateTagsAlignFlowLayoutAlignType)cellType;
//全能初始化方法 其他方式初始化最终都会�走到这里
-(instancetype)initWithType:(CGXCustomStateTagsAlignFlowLayoutAlignType) cellType betweenOfCell:(CGFloat)betweenOfCell;

@end

NS_ASSUME_NONNULL_END
