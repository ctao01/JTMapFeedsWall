//
//  UZCustomNavigationBar.h
//  UZCustomizeProject
//
//  Created by Joy Tao on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface JTCustomNavigationBar : UINavigationBar
{
    UIImageView *navigationBarBackgroundImage;
    CGFloat backButtonCapWidth;
    UINavigationController * navigationController;
}

@property (nonatomic, retain) UIImageView *navigationBarBackgroundImage;
@property (nonatomic, retain) UINavigationController * navigationController;

-(void) setBackgroundWith:(UIImage*)backgroundImage;
-(void) clearBackground;
-(UIButton*) backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage leftCapWidth:(CGFloat)capWidth;
-(void) setText:(NSString*)text onBackButton:(UIButton*)backButton;


@end
