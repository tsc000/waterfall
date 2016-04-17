//
//  ViewController.m
//  瀑布流
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"

#import "SCCollectionViewFlowLayout.h"
#import "SCCollectionView.h" //collectionView
#import "SCShop.h"

@interface ViewController ()


//存放每个cell显示的内容
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (NSMutableArray *)contents {
    if (!_contents) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop.plist" ofType:nil]];
        NSMutableArray *arrayM = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SCShop *shop = [SCShop shopWithDict:obj];
            [arrayM addObject:shop];
        }];
        _contents  = arrayM;
    }
    return _contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCCollectionViewFlowLayout *flowLayout = [[SCCollectionViewFlowLayout alloc] init];
    
//    flowLayout.columnCount = 5;
//    flowLayout.columnSpacing = 20;
//    flowLayout.verticalSpacing = 20;
    flowLayout.insets = UIEdgeInsetsMake(20, 20, 20, 20);
    SCCollectionView *collectionView = [[SCCollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor  = [UIColor whiteColor];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    flowLayout.delegate = collectionView;
    collectionView.contents  = self.contents;
}



@end
