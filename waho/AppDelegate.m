//
//  AppDelegate.m
//  waho
//
//  Created by Miguel Araújo on 6/12/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "AppDelegate.h"
#import "TabViewController.h"
#import "ViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    int cnt_redbull = 1; // add 1 to each one you drink \o/
    
     [PFImageView class];
    
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(16452420)];
    
        //Customizing tabBarController
        UITabBarController * tabBarController = (UITabBarController *)self.window.rootViewController;
        UITabBar *tabBar = tabBarController.tabBar;
    
        // repeat for every tab, but increment the index each time
        UITabBarItem *firstTab = [tabBar.items objectAtIndex:0];
        UITabBarItem *secondTab = [tabBar.items objectAtIndex:1];
        UITabBarItem *thirdTab = [tabBar.items objectAtIndex:2];
    
        // also repeat for every tab
        firstTab.image = [[UIImage imageNamed:@"terra"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        firstTab.selectedImage = [[UIImage imageNamed:@"terra_cheia"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        thirdTab.image = [[UIImage imageNamed:@"Me"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        thirdTab.selectedImage = [[UIImage imageNamed:@"Me_cheio"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    
        // also repeat for every tab
        secondTab.image = [[UIImage imageNamed:@"bandeira_vazia"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        secondTab.selectedImage = [[UIImage imageNamed:@"bandeira"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:251.0/255.0 green:11.0/255.0 blue:68.0/255.0 alpha:1.0] }
                                                 forState:UIControlStateSelected];

//    // [Optional] Power your app with Local Datastore. For more info, go to
//    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"AYFue0VQw1Xt3CeZpbXiVlDeX2xTE7EE3QHvwivP"
                  clientKey:@"dZ58w8TBhE4bz1NkSAzQ4JwL9PGBms0vPngK5pjL"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //Customizing the Color of Back button
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //Changing the Font of Navigation Bar Title
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Comfortaa-Light" size:21.0], NSFontAttributeName, nil]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //Page control
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:251.0/255.0 green:11.0/255.0 blue:68.0/255.0 alpha:1.0];
    pageControl.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( [defaults integerForKey:@"view_tuts"] != nil ) { // makes the tutorial load every time , remove this for load just the first time
        [defaults setInteger:0 forKey:@"view_tuts"];
        [defaults synchronize];
    }
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

@end
