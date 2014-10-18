//
//  ModelController.h
//  Ping Me
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 Michael L Poon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

