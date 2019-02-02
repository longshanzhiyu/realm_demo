//
//  User.m
//  RealmDemo
//
//  Created by njw on 2019/2/2.
//  Copyright © 2019 njw. All rights reserved.
//

#import "User.h"

@implementation User
// 反向关系
+ (NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties
{
    return @{@"posts": [RLMPropertyDescriptor descriptorWithClass:Post.class propertyName:@"author"]};
}
@end
