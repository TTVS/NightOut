////
////  RKCardView.m
////  RKCard
////
////  Created by Richard Kim on 11/5/14.
////  Copyright (c) 2014 Richard Kim. All rights reserved.
////
//
///*
// 
// Copyright (c) 2014 Choong-Won Richard Kim <cwrichardkim@gmail.com>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished
// to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// 
// */
//
//
//
//#import "RKCardView.h"
//
//// Responsive view ratio values
//#define CORNER_RATIO 0.015
//#define CP_RATIO 0.38
//#define PP_RATIO 0.247
//#define PP_X_RATIO 0.03
//#define PP_Y_RATIO 0.213
//#define PP_BUFF 1.0
//#define LABEL_Y_RATIO .012
//
//@implementation RKCardView {
//    UIVisualEffectView *visualEffectView;
//}
//@synthesize delegate;
//@synthesize profileImageView;
//@synthesize coverImageView;
//@synthesize titleLabel;
//@synthesize descriptionLabel;
//
//@synthesize pokeButton;
//
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupView];
//    }
//    return self;
//}
//
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if(self) {
//        [self setupView];
//    }
//    return self;
//}
//
//- (void)addShadow
//{
//    self.layer.shadowOpacity = 0.15;
//}
//
//- (void)removeShadow
//{
//    self.layer.shadowOpacity = 0;
//}
//
//-(void)setupView
//{
//    
//    
////    self.backgroundColor = [UIColor whiteColor];
//    self.backgroundColor = [UIColor colorWithRed:23.0f/255.0f green:23.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
//    self.layer.cornerRadius = self.frame.size.width * CORNER_RATIO;
//    self.layer.shadowRadius = 3;
//    self.layer.shadowOpacity = 0;
//    self.layer.shadowOffset = CGSizeMake(1, 1);
//    [self setupPhotos];
//}
//
//-(void)setupPhotos
//{
//    CGFloat height = self.frame.size.height;
//    CGFloat width = self.frame.size.width;
//    UIView *cp_mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height * CP_RATIO)];
//    UIView *pp_mask = [[UIView alloc]initWithFrame:CGRectMake(width * PP_X_RATIO, height * PP_Y_RATIO, height * PP_RATIO, height *PP_RATIO)];
//    UIView *pp_circle = [[UIView alloc]initWithFrame:CGRectMake(pp_mask.frame.origin.x - PP_BUFF, pp_mask.frame.origin.y - PP_BUFF, pp_mask.frame.size.width + 2* PP_BUFF, pp_mask.frame.size.height + 2*PP_BUFF)];
//    pp_circle.backgroundColor = [UIColor colorWithRed:90.0/255.0 green:225.0/255.0 blue:200.0/255.0 alpha:1.0];
////    pp_circle.backgroundColor = [UIColor cyanColor];
//
//    pp_circle.layer.cornerRadius = pp_circle.frame.size.height/2;
//    pp_mask.layer.cornerRadius = pp_mask.frame.size.height/2;
//    pp_mask.backgroundColor = [UIColor darkGrayColor];
//    cp_mask.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
//    
//    CGFloat cornerRadius = self.layer.cornerRadius;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cp_mask.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = cp_mask.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cp_mask.layer.mask = maskLayer;
//    
//    
//    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    
//    visualEffectView.frame = cp_mask.frame;
//    visualEffectView.alpha = 0;
//    
//    profileImageView = [[UIImageView alloc]init];
//    profileImageView.frame = CGRectMake(0, 0, pp_mask.frame.size.width, pp_mask.frame.size.height);
//    
//    profileImageView.layer.masksToBounds = YES;
//    profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2;
//    profileImageView.clipsToBounds = YES;
//    
//    coverImageView = [[UIImageView alloc]init];
//    coverImageView.frame = cp_mask.frame;
//    [coverImageView setContentMode:UIViewContentModeScaleAspectFill];
//    
//    [cp_mask addSubview:coverImageView];
//    [pp_mask addSubview:profileImageView];
//    cp_mask.clipsToBounds = YES;
//    pp_mask.clipsToBounds = YES;
//    
//    // Setup the label
//    CGFloat titleLabelX = pp_circle.frame.origin.x + pp_circle.frame.size.width + 10;
//    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, cp_mask.frame.size.height + 8, self.frame.size.width - titleLabelX, 26)];
//    titleLabel.adjustsFontSizeToFitWidth = NO;
//    titleLabel.lineBreakMode = NSLineBreakByClipping;
////    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
//    [titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:20]];
//
////    [titleLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
//    [titleLabel setTextColor:[UIColor colorWithRed:90.0/255.0 green:225.0/255.0 blue:200.0/255.0 alpha:1.0]];
////    [titleLabel setBackgroundColor:[UIColor colorWithRed:90 green:225 blue:200 alpha:1]];
//    titleLabel.text = @"Title Label";
//    
//    // Setup title banner
//    CGFloat titleBannerX = pp_circle.frame.origin.x + pp_circle.frame.size.width/2;
//    UIView *titleBanner = [[UIView alloc]initWithFrame:CGRectMake(titleBannerX, cp_mask.frame.size.height, self.frame.size.width - titleBannerX, 44)];
////    UIView *titleBanner = [[UIView alloc]initWithFrame:CGRectMake(0, cp_mask.frame.size.height, width, 44)];
//
////    titleBanner.backgroundColor = [UIColor darkGrayColor];
//    titleBanner.backgroundColor = [UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
//
//    
//    
//    // Setup description label
//    CGFloat descriptionLabelY = pp_circle.frame.origin.y + pp_circle.frame.size.height;
//    descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, descriptionLabelY + 10, self.frame.size.width - 60, 250)];
//    descriptionLabel.adjustsFontSizeToFitWidth = NO;
//    descriptionLabel.lineBreakMode = NSLineBreakByClipping;
//    descriptionLabel.contentMode = UIViewContentModeTopLeft;
//    descriptionLabel.numberOfLines = 12;
//    [descriptionLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
////    [descriptionLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
//    [descriptionLabel setTextColor:[UIColor whiteColor]];
//    descriptionLabel.text = @"Description Label";
//    
//    // Setup poke button
//    pokeButton = [[UIButton alloc]initWithFrame:CGRectMake(30, height - 70, self.frame.size.width - 60, 55)];
//    pokeButton.highlighted = YES;
//    pokeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [pokeButton setImage:[UIImage imageNamed:@"pokeButtonActive"] forState: UIControlStateNormal];
//    [pokeButton setImage:[UIImage imageNamed:@"pokeButtonInactive"] forState: UIControlStateHighlighted];
//
//    // Register touch events on the label
//    titleLabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGestureTitle =
//    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTap)];
//    [titleLabel addGestureRecognizer:tapGestureTitle];
//    
//    // Register touch events on the cover image
//    coverImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGestureCover =
//    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverPhotoTap)];
//    [coverImageView addGestureRecognizer:tapGestureCover];
//
//    // Register touch events on the profile image
//    profileImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGestureProfile =
//    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profilePhotoTap)];
//    [profileImageView addGestureRecognizer:tapGestureProfile];
//    
//    // Register touch events on the description label
//    descriptionLabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGestureDescription =
//    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(descriptionLabelTap)];
//    [titleLabel addGestureRecognizer:tapGestureDescription];
//    
//    // Register touch events on poke button
//    pokeButton.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesturePoke =
//    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pokeButtonTap)];
//    [titleLabel addGestureRecognizer:tapGesturePoke];
//    
//    
//    // building upp the views
//    [self addSubview:titleBanner];
////    [titleBanner addSubview:titleLabel];
//    [self addSubview:titleLabel];
//    [self addSubview:descriptionLabel];
//    [self addSubview:pokeButton];
//    [self addSubview:cp_mask];
//    [self addSubview:pp_circle];
//    [self addSubview:pp_mask];
//    [coverImageView addSubview:visualEffectView];
//    
//    
//    
//}
//
//-(void)titleLabelTap{
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(nameTap)]) {
//        [self.delegate nameTap];
//    }
//}
//
//-(void)coverPhotoTap{
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(coverPhotoTap)]) {
//        [self.delegate coverPhotoTap];
//    }
//}
//
//-(void)profilePhotoTap{
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(profilePhotoTap)]) {
//        [self.delegate profilePhotoTap];
//    }
//}
//
//-(void)descriptionLabelTap{
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(profileDescriptionTap)]) {
//        [self.delegate profileDescriptionTap];
//    }
//}
//
//-(void)pokeButtonTap{
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(pokeButtonTap)]) {
//        [self.delegate pokeButtonTap];
//    }
//}
//
//
//
//-(void)addBlur
//{
//    visualEffectView.alpha = 1;
//}
//
//-(void)removeBlur
//{
//    visualEffectView.alpha = 0;
//}
//
//
//
//
//@end
