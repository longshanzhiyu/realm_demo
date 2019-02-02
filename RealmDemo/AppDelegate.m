//
//  AppDelegate.m
//  RealmDemo
//
//  Created by njw on 2019/2/2.
//  Copyright © 2019 njw. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>
#import "Post.h"

@interface AppDelegate ()
@property (nonatomic, strong) RLMRealm *realm;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    RLMRealm *r = [RLMRealm defaultRealm];
    
    RLMRealmConfiguration *c = [RLMRealmConfiguration defaultConfiguration];
    NSLog(@"%@", c);
    
    // bundle中的数据库不可写
    c.fileURL = [[NSBundle mainBundle] URLForResource:@"xxxx" withExtension:@"realm"];
    c.readOnly = YES;
    
    //内存数据库
    RLMRealmConfiguration *memoryC = [RLMRealmConfiguration defaultConfiguration];
//    memoryC.inMemoryIdentifier = @"memoryDataBase";
//    self.realm = [RLMRealm realmWithConfiguration:memoryC error:nil]; //需要添加强引用 否则会随着内存释放 释放掉
    
    //数据库写入通知
    
    [self.realm addNotificationBlock:^(RLMNotification  _Nonnull notification, RLMRealm * _Nonnull realm) {
        //        [self updateUI];
    }];
    
    RLMResults *results = [Post allObjects];
    [results addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (!change) {
            //第一次加载数据
//            [self.tableview reloadData];
//            return;
        }
        else {
            //具体修改某几条数据
        }
    }];
    
    // 数据模型迁移  
//    RLMRealmConfiguration *memoryC = [RLMRealmConfiguration defaultConfiguration];
    memoryC.inMemoryIdentifier = @"memoryDataBase";
    memoryC.schemaVersion = 1;
    [memoryC setMigrationBlock:^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 1) {
            [migration enumerateObjects:@"Post" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"hot"] = @([oldObject[@"look"] integerValue] + [oldObject[@"comments"] count]);
            }];
            
            //属性名修改
            [migration renamePropertyForClass:@"Post" oldName:@"title" newName:@"newTitle"];
        }
    }];
    self.realm = [RLMRealm realmWithConfiguration:memoryC error:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
