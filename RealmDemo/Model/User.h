//
//  User.h
//  RealmDemo
//
//  Created by njw on 2019/2/2.
//  Copyright © 2019 njw. All rights reserved.
//

#import <Realm/Realm.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : RLMObject
@property NSString *nickname;

//To-Many 对多 关系
@property (readonly) RLMLinkingObjects *posts;
@end

NS_ASSUME_NONNULL_END
