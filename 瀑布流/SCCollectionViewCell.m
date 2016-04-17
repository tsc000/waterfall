//
//  SCCollectionViewCell.m
//  瀑布流
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SCCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SCShop.h"

@implementation SCCollectionViewCell

//初始化cell的frame,里面顺便加载控件
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

//设置控件，里面暂定一个Label
- (void)setupUI {
    
    UIImageView *view = [UIImageView new];
//    view.frame  = self.contentView.frame;
    view.backgroundColor = [UIColor orangeColor];
    
    self.view = view;
    [self.contentView addSubview:view];
}

- (void)setShop:(SCShop *)shop {
    _shop = shop;
    
    [self.view sd_setImageWithURL:_shop.img placeholderImage:[UIImage imageNamed:@"swift.jpg"]];
//    [self.view sd_setImageWithURL:[NSURL URLWithString:_shop.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//    }];
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    //这里非得放在这里不可，因为cell的高是改变的，所以图片的高也要随着改变
    self.view.frame  = self.contentView.frame;
    
}

@end
