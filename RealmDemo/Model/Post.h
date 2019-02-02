//
//  Post.h
//  RealmDemo
//
//  Created by njw on 2019/2/2.
//  Copyright © 2019 njw. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN
RLM_ARRAY_TYPE(Post); //注意添加此处 否则 comments不起作用
@class User;
@interface Post : RLMObject

//主键
@property NSString *identifer;

//标题
@property NSString *title;

//author To-One 关系 对一关系
@property User *author;

//时间戳
@property NSDate *timestamp;

//内容
@property NSString *content;

//浏览量 //int long longlong  常量在Realm数据库里面是不可以为空的
@property NSInteger look;

@property NSInteger hot;

//回帖 对多关系
@property RLMArray <Post *><Post> *comments;

//置顶 注意 bool 与 BOOL 是两种类型
@property NSNumber <RLMBool> *isTop;

//不支持的类型 CGFloat, 请使用 float，double


@end

NS_ASSUME_NONNULL_END
