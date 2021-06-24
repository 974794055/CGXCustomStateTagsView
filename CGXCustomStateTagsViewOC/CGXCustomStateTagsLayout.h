//
//  UICollectionViewCellSpaceRightFlowLayout.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CGXCustomStateTagsLayoutAlignType){
     CGXCustomStateTagsLayoutAlignWithLeft,
     CGXCustomStateTagsLayoutAlignWithRight
};
@interface  CGXCustomStateTagsLayout : UICollectionViewFlowLayout

//cell对齐方式
@property (nonatomic,assign) CGXCustomStateTagsLayoutAlignType cellType;
@property (nonatomic,assign) CGFloat moreWidth;
@property (nonatomic,strong,readonly) NSMutableArray<UICollectionViewLayoutAttributes *> *hiddenArray;

@end

NS_ASSUME_NONNULL_END
