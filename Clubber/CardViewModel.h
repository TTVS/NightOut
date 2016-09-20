//
//  CardViewModel.h
//  Clubber
//
//  Created by Terra on 9/21/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PaperKit/PaperKit.h>

@class PaperRootViewController;

@protocol CardViewModel <NSObject>

@required
- (NSString *)profileName;
- (UIImage *)profilePhoto;
- (UIImage *)coverPhoto;
- (NSString *)profileDescription;


@end