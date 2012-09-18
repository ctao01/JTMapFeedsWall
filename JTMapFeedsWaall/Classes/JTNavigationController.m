//
//  JTNavigationController.m
//  JTMapFeedsWaall
//
//  Created by Joy Tao on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JTNavigationController.h"
#import "JTCustomNavigationBar.h"

@implementation JTNavigationController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        JTCustomNavigationBar * customNavigationBar = [[JTCustomNavigationBar alloc]init];
        //        // Set the nav bar's background
        [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"JT_navigation_bar_saddle"]];
        // Create a custom back button
        
        UIButton * backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
        backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        [self setValue:customNavigationBar forKeyPath:@"navigationBar"];
    }
    return self;
}


@end
