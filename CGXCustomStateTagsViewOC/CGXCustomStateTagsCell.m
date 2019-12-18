//
//  CGXCustomStateTagsCell.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsCell.h"
#import "UIButton+CGXCustomStateTagsEdgeInsets.h"
#import "UIView+CGXCustomStateTagsRounded.h"
@interface  CGXCustomStateTagsCell()

@property (nonatomic , strong) CGXCustomStateTagsModel *model;


@end
@implementation  CGXCustomStateTagsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagsButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.tagsButton];
        self.tagsButton.layer.masksToBounds=YES;
        self.tagsButton.userInteractionEnabled = NO;
        [self.tagsButton setAdjustsImageWhenHighlighted:NO];
        [self updateFrame];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrame];
}
- (void)updateFrame
{
    self.tagsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}
- (void)updateWithModel:( CGXCustomStateTagsModel *)model
{
    self.model = model;
    [self.tagsButton setTitle:@"" forState:UIControlStateNormal];
    [self.tagsButton setImage:[UIImage new] forState:UIControlStateNormal];
    switch (model.stateType) {
        case TagsModelTypeTitle:
        {
            [self.tagsButton setTitleColor:model.tagsColor forState:UIControlStateNormal];
            [self.tagsButton.titleLabel setFont:model.tagsFont];
            [self.tagsButton setTitle:model.tagsStr forState:UIControlStateNormal];
        }
            break;
        case TagsModelTypeImage:
        {
            
            [self.tagsButton setImage:[UIImage imageNamed:model.tagsImg] forState:UIControlStateNormal];
        }
            break;
        case TagsModelTypeAll:
        {
            [self.tagsButton setTitleColor:model.tagsColor forState:UIControlStateNormal];
            [self.tagsButton.titleLabel setFont:model.tagsFont];
            [self.tagsButton setTitle:model.tagsStr forState:UIControlStateNormal];
            
            [self.tagsButton setImage:[UIImage imageNamed:model.tagsImg] forState:UIControlStateNormal];
            if (model.btnType==TagsModelBtnTypeTop) {
                [self.tagsButton customStateTagsEdgeInsetsEdgeInsetsStyle:CGXCustomStateTagsEdgeInsetsTypeTop Space:model.tagsSpace];
            }
            if (model.btnType==TagsModelBtnTypeBottom) {
                [self.tagsButton customStateTagsEdgeInsetsEdgeInsetsStyle:CGXCustomStateTagsEdgeInsetsTypeBottom  Space:model.tagsSpace];
            }
            if (model.btnType==TagsModelBtnTypeLeft) {
                [self.tagsButton customStateTagsEdgeInsetsEdgeInsetsStyle:CGXCustomStateTagsEdgeInsetsTypeLeft Space:model.tagsSpace];
            }
            if (model.btnType==TagsModelBtnTypeRight) {
                [self.tagsButton customStateTagsEdgeInsetsEdgeInsetsStyle:CGXCustomStateTagsEdgeInsetsTypeRight Space:model.tagsSpace];
            }
        }
            break;
        default:
            break;
    }
    [self updateFrame];
    [self.tagsButton cornerRadiusCustomStateTags:CGSizeMake(model.tagsCornerRadius, model.tagsCornerRadius) cornerColor:[[UIColor whiteColor] colorWithAlphaComponent:0] corners:UIRectCornerAllCorners borderColor:model.tagsBorderColor borderWidth:model.tagsBorderWidth];
    
}

///**
// *  生成图片
// *
// *  @param color  图片颜色
// *
// *  @return 生成的图片
// */
//- (UIImage*)imageWithColor:(UIColor*)color
//{
//    return [self imageWithColor:color andHeight:1.0f];
//}
///**
// *  生成图片
// *
// *  @param color  图片颜色
// *  @param height 图片高度
// *
// *  @return 生成的图片
// */
//- (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height
//{
//    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
//    UIGraphicsBeginImageContext(r.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, r);
//
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return img;
//}

@end
