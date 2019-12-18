//
//  CGXCustomStateTagsModel.h
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGXCustomStateTagsModelTitleType){
    TagsModelTypeTitle,//只有文字
    TagsModelTypeImage,//只有图片
    TagsModelTypeAll//文字 图片
};

typedef NS_ENUM(NSInteger, CGXCustomStateTagsModelBtnType){
    TagsModelBtnTypeTop,//图片在上
    TagsModelBtnTypeBottom, //图片在下
    TagsModelBtnTypeLeft,//图片在左
    TagsModelBtnTypeRight//图片在右
};

@interface  CGXCustomStateTagsModel : NSObject

@property (nonatomic , assign)  CGXCustomStateTagsModelTitleType stateType;

@property (nonatomic , assign)  CGXCustomStateTagsModelBtnType btnType;

@property (nonatomic , assign) NSInteger tag;
@property (nonatomic , strong) UIColor *tagsBgColor;// 背景色

@property (nonatomic , strong) NSString *tagsImg;//图片
@property (nonatomic , assign) CGSize tagsImgSize;//图片大小

@property (nonatomic , assign) CGFloat tagsSpace;//图文间距。两边延伸距离  默认5

@property (nonatomic , assign) CGFloat tagsIncrement;//cell宽度补偿。默认：10

@property (nonatomic , assign) CGFloat tagsMarginTop;//图文上间距。图文有用 默认10 图文两边之和
@property (nonatomic , assign) CGFloat tagsMarginBottom;//图文下间距。图文有用 默认10 图文两边之和

@property (nonatomic , assign) BOOL tagsIsSelect;//是否选中
@property (nonatomic , assign) BOOL isClick;// 是否可以点击 默认可以

@property (nonatomic , strong) NSString *tagsStr;//标签文字
@property (nonatomic , strong) UIFont *tagsFont;//默认字体
@property (nonatomic , strong) UIColor *tagsColor;//默认颜色
@property (nonatomic , strong) UIFont *tagsSelectFont;//选中字体
@property (nonatomic , strong) UIColor *tagsSelectColor;//选中颜色

@property (nonatomic , assign) BOOL tagsHaveBorder;//是否有边框

@property (nonatomic , strong) UIColor *tagsBorderColor;//边框颜色
@property (nonatomic , strong) UIColor *tagsSelectBorderColor;//边框选中颜色

@property (nonatomic , assign) CGFloat tagsBorderWidth;//边框宽度
@property (nonatomic , assign) CGFloat tagsCornerRadius;//圆角


//自适应宽度 默认YES
@property (nonatomic , assign) BOOL isAdaptiveWidth;
// isAdaptiveWidth = NO有效
@property (nonatomic , assign) CGFloat tagsWidth;


@end

NS_ASSUME_NONNULL_END
