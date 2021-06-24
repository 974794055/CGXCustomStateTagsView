//
//  UICollectionViewCellSpaceRightFlowLayout.m
//  CGXCustomStateTagsView
//
//  Created by  CGX on 2018/05/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCustomStateTagsLayout.h"
@interface  CGXCustomStateTagsLayout()
{
    //在居中对齐的时候需要知道这行所有cell的宽度总和
    CGFloat _sumCellWidth ;
}
@property (nonatomic,strong,readwrite) NSMutableArray<UICollectionViewLayoutAttributes *> *hiddenArray;
@end
@implementation  CGXCustomStateTagsLayout



-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.moreWidth = 60;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.cellType = CGXCustomStateTagsLayoutAlignWithRight;
    }
    return self;
}
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)hiddenArray
{
    if (!_hiddenArray) {
        _hiddenArray = [NSMutableArray array];
    }
    return _hiddenArray;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc]initWithArray:layoutAttributes_t copyItems:YES];
    //用来临时存放一行的Cell数组
    NSMutableArray * layoutAttributesTemp = [[NSMutableArray alloc]init];
//    [self.hiddenArray removeAllObjects];
    for (NSUInteger index = 0; index < layoutAttributes.count ; index++) {
        
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[index]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : layoutAttributes[index-1]; // 上一个cell 的位置信
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == layoutAttributes.count ?
        nil : layoutAttributes[index+1];//下一个cell 位置信息
        
        //加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        _sumCellWidth += currentAttr.frame.size.width;
        
        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        //如果当前cell是单独一行
        if (currentY != previousY && currentY != nextY){
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                [layoutAttributesTemp removeAllObjects];
                _sumCellWidth = 0.0;
            }else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
                [layoutAttributesTemp removeAllObjects];
                _sumCellWidth = 0.0;
            }else{
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        //如果下一个cell在本行，这开始调整Frame位置
        else if( currentY != nextY) {
            [self setCellFrameWith:layoutAttributesTemp];
        }
        currentAttr.hidden = NO;
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:0];
        
       
        if (self.cellType == CGXCustomStateTagsLayoutAlignWithRight) {
            if (CGRectGetMinX(currentAttr.frame)<= self.collectionView.collectionViewLayout.collectionViewContentSize.width-CGRectGetWidth(self.collectionView.frame)+self.moreWidth+sectionInset.left) {
                currentAttr.hidden = YES;
                [self.hiddenArray addObject:currentAttr];
            }
        } else{
            if (CGRectGetMaxX(currentAttr.frame)+self.moreWidth+sectionInset.right >= CGRectGetWidth(self.collectionView.frame)) {
                currentAttr.hidden = YES;
                [self.hiddenArray addObject:currentAttr];
            }
        }
    }
    return layoutAttributes;
}

//调整属于同一行的cell的位置frame
-(void)setCellFrameWith:(NSMutableArray*)layoutAttributes{
    CGFloat nowWidth = 0.0;
    
    UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:0];
    switch (_cellType) {
        case  CGXCustomStateTagsLayoutAlignWithLeft:
            nowWidth = sectionInset.left;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth;
                attributes.frame = nowFrame;
                nowWidth += nowFrame.size.width + [self gx_minimumInteritemSpacingForSectionAtIndex:attributes.indexPath.section];
            }
            _sumCellWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
        case  CGXCustomStateTagsLayoutAlignWithRight:
            nowWidth = self.collectionView.frame.size.width - sectionInset.right;
            for (NSInteger index = layoutAttributes.count - 1 ; index >= 0 ; index-- ) {
                UICollectionViewLayoutAttributes * attributes = layoutAttributes[index];
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth - nowFrame.size.width;
                attributes.frame = nowFrame;
                nowWidth = nowWidth - nowFrame.size.width - [self gx_minimumInteritemSpacingForSectionAtIndex:attributes.indexPath.section];
            }
            _sumCellWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
        default:
            break;
    }
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;

}
- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.minimumInteritemSpacing;
    }
}
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return self.minimumLineSpacing;
    }
}

- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    } else {
        return self.sectionInset;
    }
}

@end
