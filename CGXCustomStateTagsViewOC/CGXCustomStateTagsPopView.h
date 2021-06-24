//
//  CGXCustomStateTagsPopView.h
//  CGXCustomStateTagsView
//
//  Created by CGX on 2021/6/20.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCustomStateTagsModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ShowViewType) {
    ShowViewTypeTopLeft,
    ShowViewTypeTopRight,
    ShowViewTypeBottomLeft,
    ShowViewTypeBottomRight
};
/*
 点击按钮的事件
 */
typedef void (^ CGXCustomStateTagsPopViewSelectBlock)(CGXCustomStateTagsModel *tagItem);

@interface CGXCustomStateTagsPopView : UIView


@property (nonatomic, assign) ShowViewType type;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat indicatorRound;
@property (nonatomic, assign) CGFloat indicatorWidth;
@property (nonatomic, assign) CGFloat indicatorHeight;

@property (nonatomic, strong) UIColor *indicatorborderColor;
@property (nonatomic, assign) CGFloat indicatorborderWidth;


- (void)updateWithTagsArray:(NSMutableArray<CGXCustomStateTagsModel *> *)array SeectBlock:(CGXCustomStateTagsPopViewSelectBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
