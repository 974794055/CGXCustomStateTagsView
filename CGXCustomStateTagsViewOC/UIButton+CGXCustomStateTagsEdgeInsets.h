//
//  UIButton+CGXCustomStateTagsEdgeInsets.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGXCustomStateTagsEdgeInsetsType) {
    CGXCustomStateTagsEdgeInsetsTypeLeft, //图片在左, 文字在右
    CGXCustomStateTagsEdgeInsetsTypeTop,  //图片在上, 文字在下
    CGXCustomStateTagsEdgeInsetsTypeBottom, //图片在下, 文字在上
    CGXCustomStateTagsEdgeInsetsTypeRight //图片在右, 文字在左
};

@interface UIButton (CGXCustomStateTagsEdgeInsets)

- (void)customStateTagsEdgeInsetsEdgeInsetsStyle:(CGXCustomStateTagsEdgeInsetsType)style Space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
