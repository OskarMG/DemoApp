//
//  SceneDelegate.m
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

#import "SceneDelegate.h"
#import "ContactListController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [self setupNavigationController];
    [self.window makeKeyAndVisible];
}

/// Creates and returns a navigation controller with `ViewController` subclass as its root.
///
/// @return A `UINavigationController` with a `MainViewController` instance as its root.
- (UINavigationController *)setupNavigationController {
    ContactListController *vc = [[ContactListController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: vc];
    return navController;
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
