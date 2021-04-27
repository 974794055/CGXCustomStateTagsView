//
//  CGXCustomStateTagsModel.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsModel.h"

@implementation  CGXCustomStateTagsModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagsBgColor = [UIColor whiteColor];
        self.isAdaptiveWidth = YES;
        self.tagsWidth = 60;
        self.stateType = TagsModelTypeTitle;
        self.tagsCornerRadius = 4;
        self.tagsBorderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        self.tagsBorderWidth = 1;
        self.tagsColor = [UIColor blackColor];
        self.tagsFont = [UIFont systemFontOfSize:14];
        self.tagsImgSize =  CGSizeMake(25, 25);
        self.tagsSpace = 5;
        self.tagsIncrement = 10;
        self.tagsMarginTop = 5;
        self.tagsMarginBottom = 5;
    }
    return self;
}
@end
