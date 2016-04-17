//
//  SCShop.m
//  28-waterFall
//
//  Created by Mac on 16/2/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SCShop.h"

@implementation SCShop
- (instancetype)initShopWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict {
    return [[self alloc] initShopWithDict:dict];
}

@end
