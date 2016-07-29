//
//  AppDelegate.h
//  IndividualWorks
//
//  Created by 陈黔 on 16/7/29.
//  Copyright © 2016年 BlackChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

