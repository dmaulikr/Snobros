//
//  AppDelegate.m
//  Snobros
//
//  Created by Tanoy Sinha on 10/23/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  EAGLContext *context = [[EAGLContext alloc]
                          initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:context];
  glEnable(GL_DEPTH_TEST);
  
  GLKView *view = [[GLKView alloc]
                   initWithFrame:[[UIScreen mainScreen]bounds]
                   context:context];
  view.delegate = self;
  view.context  = context;
  
  ViewController *controller = [[ViewController alloc] init];
  controller.delegate = self;
  controller.view     = view;
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = controller;
  [self.window makeKeyAndVisible];
  
  glClearColor(0.7, 0.7, 0.4, 0.4);
  
  map_ = [[Entity alloc] initWithFile:@"snobrosmap.png"
                             position:GLKVector2Make(0, 0)
                                 size:CGSizeMake(480, 320)];
  bro_ = [[MovableEntity alloc] initWithFile:@"snobro2.png"
                                    position:GLKVector2Make(0, 0)
                                        size:CGSizeMake(76, 95)];
  
  return YES;
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller {
  if (controller.timeSinceLastUpdate > 0.001) {
    [bro_ updateWithElapsedTime:controller.timeSinceLastUpdate];
  }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  [map_ render];
  [bro_ render];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint pt =[touch locationInView:self.window.rootViewController.view];
    [bro_ walkTo:GLKVector2Make(pt.x, pt.y)];
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint pt =[touch locationInView:self.window.rootViewController.view];
    [bro_ walkTo:GLKVector2Make(pt.x, pt.y)];
  }
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
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
