////
////  BackgroundViewController.m
////  Sample
////
////  Created by Norikazu on 2015/06/29.
////  Copyright © 2015年 Stamp inc. All rights reserved.
////
//#define viewWidth ([UIScreen mainScreen].bounds.size.width)
//#define viewHeight ([UIScreen mainScreen].bounds.size.height)
//
//#import "BackgroundViewController.h"
//#import "PaperRootViewController.h"
//#import "FullScreenContentViewController.h"
//
//@interface BackgroundViewController ()
//
//@property (nonatomic) UIButton *addButton;
//
//@end
//
//@implementation BackgroundViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [_addButton setTitle:@"add new window" forState:UIControlStateNormal];
//    [_addButton addTarget:self action:@selector(addTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [_addButton sizeToFit];
//    [_addButton setFrame:CGRectMake(0, 0, viewWidth, viewHeight/2)];
//    _addButton.center = self.view.center;
//    [self.view addSubview:_addButton];
//
//    
//}
//
//- (void)addTapped:(UIButton *)button
//{
//    PaperRootViewController *nextViewController = [PaperRootViewController new];
//    [[PKWindowManager sharedManager] showWindowWithRootViewController:nextViewController];
//}
//
//
//@end
