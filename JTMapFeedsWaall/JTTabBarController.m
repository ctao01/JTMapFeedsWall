//
//  JTTabBarController.m
//  JTMapFeedsWaall
//
//  Created by Joy Tao on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JTTabBarController.h"
#import "JTSearchViewController.h"
#import "JTFeedsViewController.h"
#import "JTMapViewController.h"
#import "JTGalleryViewController.h"
#import "JTUserViewController.h"

#import "JTNavigationController.h"

@interface JTTabBarController ()
@end

@implementation JTTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        
        // Setup View Controllers
    
        JTFeedsViewController * jtFeedsViewController = [[JTFeedsViewController alloc]init];
        jtFeedsViewController.title = @"Feeds";
        
        JTSearchViewController * jtSearchViewController = [[JTSearchViewController alloc]init];
        jtSearchViewController.title = @"Explore";
        
        JTMapViewController * jtMapViewController = [[JTMapViewController alloc]init];
        jtMapViewController.title = @"Map";
        
        JTGalleryViewController * jtGalleryViewController = [[JTGalleryViewController alloc]init];
        jtGalleryViewController.title = @"Gallery";
        
        JTUserViewController * jtUserViewController = [[JTUserViewController alloc]init];
        jtUserViewController.title = @"Proflile";
        
        // Setup UITabbarItem
        
        UITabBarItem * feedItem = [[UITabBarItem alloc]initWithTitle:@"Feed" image:nil tag:0];
        UITabBarItem * searchItem = [[UITabBarItem alloc]initWithTitle:@"Search" image:nil tag:1];
        UITabBarItem * mapItem = [[UITabBarItem alloc]initWithTitle:@"Map" image:nil tag:2];
        UITabBarItem * galleryItem = [[UITabBarItem alloc]initWithTitle:@"Gallery" image:nil tag:3];
        UITabBarItem * userItem = [[UITabBarItem alloc]initWithTitle:@"Profile" image:nil tag:4];

        // Setup Navigation Controller
        JTNavigationController * ncFeeds = [[JTNavigationController alloc]initWithRootViewController:jtFeedsViewController];
        ncFeeds.tabBarItem = feedItem;
    
        JTNavigationController * ncSearch= [[JTNavigationController alloc]initWithRootViewController:jtSearchViewController];
        ncSearch.tabBarItem = searchItem;
        
        JTNavigationController * ncMap = [[JTNavigationController alloc]initWithRootViewController:jtMapViewController];
        ncMap.tabBarItem = mapItem;
        
        JTNavigationController * ncGallery = [[JTNavigationController alloc]initWithRootViewController:jtGalleryViewController];
        ncGallery.tabBarItem = galleryItem;
        
        JTNavigationController * ncUser = [[JTNavigationController alloc]initWithRootViewController:jtUserViewController];
        ncUser.tabBarItem = userItem;
        
        
        self.viewControllers = [NSArray arrayWithObjects: ncFeeds, ncSearch , ncMap, ncGallery, ncUser, nil];
        self.selectedIndex = 4;
        
        UIImage * backgroundImage = [UIImage imageNamed:@"JT_navigation_bar_saddle.png"];
        
        // Get backgroundImage size
        float imageHeight = backgroundImage.size.height;        
        // Store the current TabBar frame
        
        CGRect tbFrame = self.tabBar.frame;
        
        // Set new frame for TabBar
        self.tabBar.frame = CGRectMake(tbFrame.origin.x, (tbFrame.origin.y + tbFrame.size.height) - imageHeight, self.view.bounds.size.width, imageHeight);
        [self.tabBar setBackgroundImage:backgroundImage];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
    {
        // store facebook data, refresh every times? 
        NSLog(@"user login via Facebook successsfully ");
        
//        [[PF_FBRequest requestForMe] startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result,NSError *error)
//         {
//            if (!error) {
//                // Store the current user's Facebook ID on the user
//                [[PFUser currentUser] setObject:[result objectForKey:@"id"]
//                                         forKey:@"fbId"];
//                [[PFUser currentUser] saveInBackground];
//            }
//        }];
    }
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITabBarController Delegate Method

- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController 
{
//	NSLog(@"Selected Index: %i", [self.viewControllers indexOfObject:viewController]);
//	
//	if ([self.viewControllers indexOfObject:viewController] == 2) {
//		[self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"UZTabBarEmptySelectionIndicator.png"]];
//	} else {
//		[self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"UZTabBarSelectionIndicator-52.png"]];
//	}
    
	return YES;
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController 
{	
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*) viewController popToRootViewControllerAnimated:NO];
    }
}


@end
