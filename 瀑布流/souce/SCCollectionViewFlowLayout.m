//
//  SCCollectionViewFlowLayout.m
//  瀑布流
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SCCollectionViewFlowLayout.h"

//collectionView宽度
#define kWIDTH (self.collectionView.frame.size.width)

//#warning
////暂时设定3列这个要动态设置
//#define column (3)
//#define cMargin (10)
//#define lMargin (10)

@interface SCCollectionViewFlowLayout()

//存储每列的列高，以便判断新cell放在哪一列
@property (nonatomic, strong) NSMutableArray *columnHeight;

@end

@implementation SCCollectionViewFlowLayout

//设置单个cell的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = ( kWIDTH - (_columnCount - 1) * self.columnSpacing - self.insets.left - self.insets.right)/_columnCount;

    //item高，代理获得数据
    CGFloat itemHeight = [self.delegate shopFlowLayout:self itemWidth:width indexPath:indexPath];
    
    //下面是遍历寻找到最小的列高度所在的位置
    CGFloat minY = [self.columnHeight[0] doubleValue];
    
    NSInteger minColumn = 0;
    
    for (int i = 0; i < _columnCount; i ++) {
        CGFloat temp = [self.columnHeight[i] doubleValue];
        if (minY  > temp) {
            minY = temp;
            minColumn = i;
        }
    }
    
    //cell x方向 坐标
    CGFloat itemX = self.insets.left + minColumn *(self.columnSpacing + width); //item x
    //cell y方向 坐标
    CGFloat itemY = minY + self.insets.top; //item y
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = CGRectMake(itemX, itemY, width, itemHeight);
    
    self.columnHeight[minColumn] = @(CGRectGetMaxY(attribute.frame));
    
    return attribute;
}

//这里获取可视区域rect里面的每个cell属性,要动态设置cell的frame
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    //将高度数组中的内容清空，因为要重新设置数据
    for (NSInteger i = 0; i < _columnCount; i++) {
        _columnHeight[i] = @0;
    }
    
    //获取cell的总数,只一有组
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    //保存每个cell的属性，用于返回
    NSMutableArray *attributes = [NSMutableArray array];
    
    //依次调用每个cell的属性设置方法来设置每个cell的属性
    for (NSInteger i = 0 ; i < count; i ++) {
        
        //获取NSIndexPath，因为调用单个cell属性方法要用作参数
        NSIndexPath *indexPath  =[NSIndexPath indexPathForItem:i inSection:0];
        
        //获取cell的属性
        UICollectionViewLayoutAttributes * attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [attributes addObject:attribute];
        
    }
    
    return attributes;
}

//collectionView 内容大小
- (CGSize)collectionViewContentSize {

    CGFloat finalHeight = 0; //最终collectionViewContent的高度
    for (NSInteger i = 0; i < self.columnHeight.count; i ++) {
        
        CGFloat tempHeight = [self.columnHeight[i] doubleValue];
        
        if ( tempHeight > finalHeight) {
            
            finalHeight = tempHeight;
        }
    }
    return CGSizeMake(kWIDTH, finalHeight + self.insets.bottom);
}

//边界改变布局是否要刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark --setter
- (void)setColumnSpacing:(CGFloat)columnSpacing {
    _columnSpacing = columnSpacing;
    //列间距不能为负数，默认为10，设置成负数也为0
    if (_columnSpacing <= .0) {
        _columnSpacing = 10;
    }
}

- (void)setVerticalSpacing:(CGFloat)verticalSpacing {
    _verticalSpacing = verticalSpacing;
    //行间距不能为负数，默认为10，设置成负数也为0
    if (_verticalSpacing <= .0) {
        _verticalSpacing = 10;
    }
}

- (void)setColumnCount:(NSInteger)columnCount {
    _columnCount = columnCount;
    //行数不能为负数，默认为3，设置成负数也为3
    if (_columnCount <= 0) {
        _columnCount = 3;
    }
}

- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    if (_insets.left <= 0) {
        _insets.left = 10;
    }

    if (_insets.right <= 0) {
        _insets.right = 10;
    }
    if (_insets.top <= 0) {
        _insets.top = 10;
    }
    if (_insets.bottom <= 0) {
        _insets.bottom = 10;
    }
}

#pragma mark --懒加载数组
- (NSMutableArray *)columnHeight {
    if (!_columnHeight) {
        _columnHeight = [NSMutableArray array];
        //这里先设置一下，要不然不会进入setter方法，就不会设置默认值
        //判断是因为外界可能对其赋值，那么就没必要再设置值了
        if (self.verticalSpacing == 0) {
            self.verticalSpacing = 0;
        }
        //判断是因为外界可能对其赋值，那么就没必要再设置值了
        if (self.columnSpacing == 0) {
            self.columnSpacing = 0;
        }
        
        //判断是因为外界可能对其赋值，那么就没必要再设置值了
        if (self.columnCount == 0) {
            self.columnCount = 3;
        }
        //判断是因为外界可能对其赋值，那么就没必要再设置值了
        if (self.insets.left == .0 &&
            self.insets.right == .0 &&
            self.insets.top == .0 &&
            self.insets.bottom == .0 ) {
            self.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        }
        
    }
    return _columnHeight;
}
@end
