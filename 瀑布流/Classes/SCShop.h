//
//  SCShop.h
//  28-waterFall
//
//  Created by Mac on 16/2/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCShop : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger h;
@property (nonatomic, assign) NSInteger w;

- (instancetype)initShopWithDict:(NSDictionary *)dict;
+ (instancetype)shopWithDict:(NSDictionary *)dict;

@end
