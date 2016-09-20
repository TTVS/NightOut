//
//  CardViewController.h
//  Clubber
//
//  Created by Terra on 9/21/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

#import <PaperKit/PaperKit.h>
//#import "RKCardView.h"
#import <UIKit/UIKit.h>

@protocol RKCardViewDelegate <NSObject>
@optional
- (void)firstNameTap;
- (void)lastNameTap;
- (void)coverPhotoTap;
- (void)profilePhotoTap;
- (void)profileDescriptionTap;
- (void)pokeButtonTap;

@end


@interface CardViewController : PKContentViewController <RKCardViewDelegate>

@property (nonatomic, weak) IBOutlet id<RKCardViewDelegate> delegate;
@property (nonatomic) PKPreviewView *previewView;

@property (nonatomic)UIImageView *profileImageView;
@property (nonatomic)UIImageView *coverImageView;
@property (nonatomic)UILabel *titleLabel;
@property (nonatomic)UILabel *titleLabel2;
@property (nonatomic)UILabel *descriptionLabel;

@property (nonatomic)UIButton *pokeButton;

- (void)addBlur;
- (void)removeBlur;
- (void)addShadow;
- (void)removeShadow;

@end
