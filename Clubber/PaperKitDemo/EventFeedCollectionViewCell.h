//
//  EventFeedCollectionViewCell.h
//  Clubber
//
//  Created by Terra on 10/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventFeedCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDescriptionLabel;

@end
