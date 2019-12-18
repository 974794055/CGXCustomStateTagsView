//
//  CGXCustomStateTagsCell.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCustomStateTagsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface  CGXCustomStateTagsCell : UICollectionViewCell

@property (nonatomic , strong) UIButton *tagsButton;

- (void)updateWithModel:(CGXCustomStateTagsModel *)model;

@end

NS_ASSUME_NONNULL_END
