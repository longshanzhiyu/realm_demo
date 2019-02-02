//
//  Post.m
//  RealmDemo
//
//  Created by njw on 2019/2/2.
//  Copyright © 2019 njw. All rights reserved.
//

#import "Post.h"
#import "User.h"

@implementation Post

// 可空属性， 决定属性是否可以为nil
+ (NSArray<NSString*> *)requiredProperties {
    return @[@"title"];
}

// 忽略属性
+ (NSArray<NSString *> *)ignoredProperties {
    return @[];
}

// 设置默认值
+ (NSDictionary *)defaultPropertyValues {
    return @{@"look" : @(0)};
}

// 索引属性 支持NSString， NSNumber（包括常量)，NSDate
+ (NSArray<NSString *> *)indexedProperties {
    return @[@"title", @"timestamp"];
}

// 主键 设置之后不可更改
+ (NSString *)primaryKey {
    return @"identifer";
}
@end
