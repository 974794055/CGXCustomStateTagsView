//
//  UIView+CGXCustomStateTagsRounded.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UIView+CGXCustomStateTagsRounded.h"
#import <objc/runtime.h>

@implementation NSObject (CGXCustomStateTagsRounded)

+ (void)gx_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)gx_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)gx_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)gx_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (CGXCustomStateTagsRounded)

+ (UIImage *)gx_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gx_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage gx_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end



static void *const gxCustomStateTagsMaskCornerRadiusLayerKey = "gxCustomStateTagsMaskCornerRadiusLayerKey";

static void *const gxCustomStateTagsCornerRadiusImageColor = "gxCustomStateTagsCornerRadiusImageColor";
static void *const gxCustomStateTagsCornerRadiusImageRadius = "gxCustomStateTagsCornerRadiusImageRadius";
static void *const gxCustomStateTagsCornerRadiusImageCorners = "gxCustomStateTagsCornerRadiusImageCorners";
static void *const gxCustomStateTagsCornerRadiusImageBorderColor = "gxCustomStateTagsCornerRadiusImageBorderColor";
static void *const gxCustomStateTagsCornerRadiusImageBorderWidth = "gxCustomStateTagsCornerRadiusImageBorderWidth";
static void *const gxCustomStateTagsCornerRadiusImageSize = "gxCustomStateTagsCornerRadiusImageSize";

static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (CGXCustomStateTagsRounded)

+ (void)load{
    [CALayer gx_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(gxCustomStateTagsRoundedlayoutSublayers)];
}

- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage{
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    
    [self cornerRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self cornerRadius:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)cornerRadius:(CGSize)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (!color){
        return;
    }
    CALayer *cornerRadiusLayer = [self gx_getAssociatedValueForKey:gxCustomStateTagsMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self gx_setAssociateValue:cornerRadiusLayer withKey:gxCustomStateTagsMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer gx_setAssociateValue:color withKey:gxCustomStateTagsCornerRadiusImageColor];
    }else{
        [cornerRadiusLayer gx_removeAssociateWithKey:gxCustomStateTagsCornerRadiusImageColor];
    }
    [cornerRadiusLayer gx_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:gxCustomStateTagsCornerRadiusImageRadius];
    [cornerRadiusLayer gx_setAssociateValue:@(corners) withKey:gxCustomStateTagsCornerRadiusImageCorners];
    if (borderColor) {
        [cornerRadiusLayer gx_setAssociateValue:borderColor withKey:gxCustomStateTagsCornerRadiusImageBorderColor];
    }else{
        [cornerRadiusLayer gx_removeAssociateWithKey:gxCustomStateTagsCornerRadiusImageBorderColor];
    }
    [cornerRadiusLayer gx_setAssociateValue:@(borderWidth) withKey:gxCustomStateTagsCornerRadiusImageBorderWidth];
    UIImage *image = [self gx_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)gx_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self gx_getAssociatedValueForKey:gxCustomStateTagsMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageColor];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageRadius] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageCorners] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageBorderWidth] floatValue];
    UIColor *borderColor = [cornerRadiusLayer gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageBorderColor];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageSize] CGSizeValue];
        UIColor *imageColor = [obj gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageColor];
        CGSize imageRadius = [[obj gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageRadius] CGSizeValue];
        NSUInteger imageCorners = [[obj gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageCorners] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageBorderWidth] floatValue];
        UIColor *imageBorderColor = [obj gx_getAssociatedValueForKey:gxCustomStateTagsCornerRadiusImageBorderColor];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage gx_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image gx_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:gxCustomStateTagsCornerRadiusImageSize];
        [image gx_setAssociateValue:color withKey:gxCustomStateTagsCornerRadiusImageColor];
        [image gx_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:gxCustomStateTagsCornerRadiusImageRadius];
        [image gx_setAssociateValue:@(corners) withKey:gxCustomStateTagsCornerRadiusImageCorners];
        if (borderColor) {
            [image gx_setAssociateValue:color withKey:gxCustomStateTagsCornerRadiusImageBorderColor];
        }
        [image gx_setAssociateValue:@(borderWidth) withKey:gxCustomStateTagsCornerRadiusImageBorderWidth];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)gxCustomStateTagsRoundedlayoutSublayers {
    
    [self gxCustomStateTagsRoundedlayoutSublayers];
    CALayer *cornerRadiusLayer = [self gx_getAssociatedValueForKey:gxCustomStateTagsMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self gx_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end

@implementation UIView (CGXCustomStateTagsRounded)


- (void)cornerRadiusCustomStateTags:(CGFloat)radius cornerColor:(UIColor *)color {
    
    [self.layer cornerRadius:radius cornerColor:color];
}

- (void)cornerRadiusCustomStateTags:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self.layer cornerRadius:radius cornerColor:color corners:corners];
}

- (void)cornerRadiusCustomStateTags:(CGSize)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    [self.layer cornerRadius:radius cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end
