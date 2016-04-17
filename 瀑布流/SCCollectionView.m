//
//  SCCollectionView.m
//  瀑布流
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SCCollectionView.h"
#import "SCCollectionViewCell.h" //cell
#import "SCCollectionViewFlowLayout.h" //flowLayout
#import "SCShop.h"

@interface SCCollectionView()<
UICollectionViewDataSource,
UICollectionViewDelegate,
SCShopFlowLayoutDelegate //flowlayout协议
>

@end

@implementation SCCollectionView

//初始化collectionView,自定义
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    //这里可以传自定义的collectionViewFlowlayout
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        [self initial];
    }
    return self;
}

//初始化CollectionView的一些配置
- (void)initial {

    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[SCCollectionViewCell class] forCellWithReuseIdentifier:@"SCCollectionViewCell"];
}
- (void)setContents:(NSMutableArray *)contents {
    _contents = contents;
    [self reloadData];
}

//CollectionView组数
- (NSInteger)numberOfSections {
    return 1;
}

//CollectionView每组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contents.count;
}

//CollectionView每个cell显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"SCCollectionViewCell";
    
    SCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    cell.shop = self.contents[indexPath.row];
    
    return cell;
}

- (CGFloat)shopFlowLayout:(SCCollectionViewFlowLayout *)flowLayout itemWidth:(CGFloat)width indexPath:(NSIndexPath *)indexpath {
    
    SCShop *shop =self.contents[indexpath.item];
    
    CGFloat itemHeight = width * shop.h/shop.w;
    
    return itemHeight;
}

@end
