//
//  SCCollectionViewFlowLayout.h
//  瀑布流
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#warning 要使用SCCollectionViewFlowLayout，要遵守一下协议

#import <UIKit/UIKit.h>

@class SCCollectionViewFlowLayout;

@protocol SCShopFlowLayoutDelegate <NSObject>

//获取高度
- (CGFloat)shopFlowLayout:(SCCollectionViewFlowLayout *)flowLayout itemWidth:(CGFloat)width indexPath:(NSIndexPath *)indexpath;

@end


@interface SCCollectionViewFlowLayout : UICollectionViewFlowLayout

//获取cell高度的代理
@property (nonatomic, weak) id delegate;

//行间距
@property (nonatomic, assign) CGFloat columnSpacing;
//列间距
@property (nonatomic, assign) CGFloat verticalSpacing;
//列数
@property (nonatomic, assign) NSInteger columnCount;
//content 的四周边距
@property (nonatomic, assign) UIEdgeInsets insets;

@end
