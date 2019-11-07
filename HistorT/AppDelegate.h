//
//  AppDelegate.h
//  HistorT
//
//  Created by Macbook Pro on 28/12/18.
//  Copyright © 2018 com. HistorT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end

