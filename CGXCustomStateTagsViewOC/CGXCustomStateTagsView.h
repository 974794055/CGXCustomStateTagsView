//
//  CGXCustomStateTagsView.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//
/*
支持pod下载：搜索：CGXCustomStateTagsView
版本： 1.1.1
 
 
 功能：
   状态按钮功能封装   (例如：订单状态等固定式按钮使用，不可滑动)
*/

#import <UIKit/UIKit.h>
#import "CGXCustomStateTagsModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGXCustomStateTagsViewAlignType){
     CGXCustomStateTagsViewAlignWithLeft,
     CGXCustomStateTagsViewAlignWithCenter,
     CGXCustomStateTagsViewAlignWithRight
};

/*
 点击按钮的事件
 */
typedef void (^ CGXCustomStateTagsViewSelectStateBlock)(CGXCustomStateTagsModel *tagItem ,NSInteger inter);

@interface  CGXCustomStateTagsView : UIView
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong,readonly) NSMutableArray< CGXCustomStateTagsModel *> *dataArray;//数据源数组
@property (nonatomic , copy)  CGXCustomStateTagsViewSelectStateBlock selectStateBlock;

@property (nonatomic , assign) UIEdgeInsets inset;
@property (nonatomic , assign) CGFloat minimumLineSpacing;
@property (nonatomic , assign) CGFloat minimumInteritemSpacing;

//cell对齐方式
@property (nonatomic,assign) CGXCustomStateTagsViewAlignType cellType;

- (void)updateWithTagsArray:(NSMutableArray<CGXCustomStateTagsModel *> *)array;
@end

NS_ASSUME_NONNULL_END
