//
//  SCCollectionViewCell.h
//  瀑布流
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCShop;
@interface SCCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SCShop *shop;
@property (nonatomic, weak) UIImageView *view;

@end
