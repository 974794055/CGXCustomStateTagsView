//
//  CGXCustomStateTagsCell.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsCell.h"
#import "UIButton+CGXCustomStateTagsEdgeInsets.h"

@interface  CGXCustomStateTagsCell()

@property (nonatomic , strong) CGXCustomStateTagsModel *model;
@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;

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
        self.tagsButton.clipsToBounds=YES;
        self.tagsButton.userInteractionEnabled = NO;
        [self.tagsButton setAdjustsImageWhenHighlighted:NO];
   
    self.tagsButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.tagsButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self.contentView addConstraint:self.hotImageTop];
        [self.contentView addConstraint:self.hotImageLeft];
        [self.contentView addConstraint:self.hotImageRight];
        [self.contentView addConstraint:self.hotImageBottom];

        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hotImageTop.constant = 0;
    self.hotImageBottom.constant = 0;
    self.hotImageLeft.constant = 0;
    self.hotImageRight.constant = 0;
}
- (void)updateWithModel:( CGXCustomStateTagsModel *)model
{
    self.model = model;
    self.hotImageTop.constant = 0;
    self.hotImageBottom.constant = 0;
    self.hotImageLeft.constant = 0;
    self.hotImageRight.constant = 0;
    
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
    self.tagsButton.layer.cornerRadius= model.tagsCornerRadius;
    self.tagsButton.layer.borderWidth = model.tagsBorderWidth;
    self.tagsButton.layer.borderColor= [model.tagsBorderColor CGColor];
}




@end
