//
//  ViewTableViewCell.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCustomStateTagsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewTableViewCell : UITableViewCell
@property (nonatomic , strong)  CGXCustomStateTagsView *tagsView;

- (void)updateModel;

@end

NS_ASSUME_NONNULL_END
