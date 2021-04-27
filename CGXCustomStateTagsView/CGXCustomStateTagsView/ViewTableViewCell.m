//
//  ViewTableViewCell.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "ViewTableViewCell.h"
///颜色随机
#define APPRandomColor     [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]
@implementation ViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tagsView = [[CGXCustomStateTagsView alloc] init];
        self.tagsView.frame = CGRectMake(0,0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
        self.tagsView.backgroundColor = [UIColor whiteColor];
        self.tagsView.cellType =  CGXCustomStateTagsViewAlignWithRight;
        self.tagsView.minimumLineSpacing = 10;
        self.tagsView.minimumInteritemSpacing = 10;
        [self.contentView addSubview:self.tagsView];
        self.tagsView.selectStateBlock = ^(CGXCustomStateTagsModel * _Nonnull tagItem, NSInteger inter) {
            NSLog(@"%@" , tagItem.tagsStr);
        };
        

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tagsView.frame = CGRectMake(0,0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}
- (void)updateModel
{
    NSMutableArray *tagsArr= [NSMutableArray arrayWithObjects:@"取消订单",@"待支付",@"评价", nil];
    NSMutableArray *tags11 = [NSMutableArray array];
    for (int i = 0; i<tagsArr.count; i++) {
        CGXCustomStateTagsModel *tagModel = [[ CGXCustomStateTagsModel alloc] init];
        tagModel.tagsStr = tagsArr[i];
        //        tagModel.tagsWidth = 50;
        //        tagModel.isAdaptiveWidth = NO;
        tagModel.stateType = TagsModelTypeTitle;
        //        tagModel.tagsBgColor = APPRandomColor;
        tagModel.tagsBorderColor = APPRandomColor;
        tagModel.tagsBorderWidth = 1;
        tagModel.tagsCornerRadius = 8;
        tagModel.tagsIncrement = 20;
        [tags11 addObject:tagModel];
    }
    [self.tagsView updateWithTagsArray:tags11];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
