//
//  SHImplementaion2VC.m
//  SHViewPager
//  version 1.0, compatible with iOS 6.0 and greater
//
//  Created by shabib hossain on 5/15/14.
//  Copyright (c) 2014 shabib hossain. All rights reserved.
//
//  This software is licenced under MIT licence.
//  Please check LICENCE.md for more details.
//

#import "SHImplementaion2VC.h"
#import "SHViewPager.h"
#import "SHContentVC.h"

@interface SHImplementaion2VC () <SHViewPagerDataSource, SHViewPagerDelegate>
{
    IBOutlet SHViewPager *pager;
    
    NSArray *menuItems;
}

@end

@implementation SHImplementaion2VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"Implementation Example 2";
        
        menuItems = [[NSArray alloc] initWithObjects:@"menu 1", @"menu 2", @"menu 3", @"menu 4", @"menu 5", @"menu 6", @"menu 7", @"menu 8", @"menu 9", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [pager reloadData];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // fixes bug for scrollview's content offset reset.
    // check SHViewPager's reloadData method to get the idea.
    // this is a hacky solution, any better solution is welcome.
    // check closed issues #1 & #2 for more details.
    // this is the example to fix the bug, to test this
    // comment out the following lines
    // and check what happens.
    
    if (menuItems.count)
    {
        [pager pagerWillLayoutSubviews];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
    return menuItems.count;
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    return self;
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    SHContentVC *contentVC = [[SHContentVC alloc] initWithNibName:@"SHContentVC" bundle:nil];
    return contentVC;
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line.png"];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager imageForPageMenuAtIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"menu%ld.png", index + 1];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager highlitedImageForPageMenuAtIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"menu%ld_h.png", index + 1];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager selectedImageForPageMenuAtIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"menu%ld_h.png", index + 1];
    return [UIImage imageNamed:imageName];
}

- (NSString *)viewPager:(SHViewPager *)viewPager headerTitleForPageMenuAtIndex:(NSInteger)index
{
    return [menuItems objectAtIndex:index];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager
{
    return SHViewPagerMenuWidthTypeNarrow;
}

#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager
{
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content will move to page %ld from page: %ld", toIndex, (long)fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content moved to page %ld from page: %ld", toIndex, (long)fromIndex);
}

@end
