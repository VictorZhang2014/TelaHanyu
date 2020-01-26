//
//  THTabBarViewController.m
//  TelaHanyu
//
//  Created by victor on 1/23/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

#import "THTabBarViewController.h"
#import "TelaHanyu-Swift.h"


@interface THTabBarViewController ()

@end

@implementation THTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    THHomeCourseViewController *homeCourseVC = [[THHomeCourseViewController alloc] init];
    UINavigationController *homeCourseVCNav = [[UINavigationController alloc] initWithRootViewController:homeCourseVC];
    homeCourseVCNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    
    THCoursePracticeViewController *coursePracticeVC = [[THCoursePracticeViewController alloc] init];
    UINavigationController *coursePracticeVCNav = [[UINavigationController alloc] initWithRootViewController:coursePracticeVC];
    coursePracticeVCNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:1];
    
    THMeViewController *meVC = [[THMeViewController alloc] init];
    UINavigationController *meVCNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    meVCNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    
    [self setViewControllers:@[homeCourseVCNav, coursePracticeVCNav, meVCNav] animated:YES];
}

@end
