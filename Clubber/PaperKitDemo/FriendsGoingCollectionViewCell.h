//
//  FriendsGoingCollectionViewCell.h
//  Clubber
//
//  Created by Terra on 10/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsGoingCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *friendsCoverPhoto;
@property (strong, nonatomic) IBOutlet UIImageView *friendsProfilePhoto;
@property (strong, nonatomic) IBOutlet UIView *friendsNameBGView;
@property (strong, nonatomic) IBOutlet UILabel *friendsNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *friendsDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *friendsPokeButton;

@end
