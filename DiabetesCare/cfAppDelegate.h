//
//  cfAppDelegate.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/8/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProfileMasterData.h"

@interface cfAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, retain) ProfileMasterData *currentUser;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) refreshCurrentUser;


@end
