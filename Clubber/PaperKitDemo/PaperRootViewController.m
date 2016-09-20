//
//  PaperRootViewController.m
//  Clubber
//
//  Created by Terra on 9/3/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

#define viewWidth ([UIScreen mainScreen].bounds.size.width)
#define viewHeight ([UIScreen mainScreen].bounds.size.height)

#import "PaperRootViewController.h"

//#import "ContentViewController.h"
//#import "FullScreenContentViewController.h"
//#import "CollectionViewController.h"

#import "CardViewController.h"
//#import "CardViewModel.h"

#import "EventFeedCollectionViewCell.h"
#import "FriendsGoingCollectionViewCell.h"

//AFNetworking
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface PaperRootViewController ()

// temporary
@property (nonatomic, strong) NSArray *backgroundImages;

@end

@implementation PaperRootViewController

-(void)viewWillAppear:(BOOL)animated{
    // Background Collection View
    [self.collectionView registerNib:[UINib nibWithNibName:@"EventFeedCollectionViewCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"eventFeedCollectionViewCell"];
    
    // Foreground Collection View
    [self.collectionView registerNib:[UINib nibWithNibName:@"FriendsGoingCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"friendsGoingCollectionViewCell"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    self.backgroundImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"image1"],
                             [UIImage imageNamed:@"image2"],
                             [UIImage imageNamed:@"image3"],
                             [UIImage imageNamed:@"image4"],
                             [UIImage imageNamed:@"image"],
                             [UIImage imageNamed:@"ImageCut"],
                             [UIImage imageNamed:@"Cut"],
                             nil];

}

//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:YES];
//
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"userLoggedIn"]] == nil) {
//        
//        UIViewController *signInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"signInVC"];
//        [self.navigationController presentViewController:signInViewController animated:YES completion:nil];
//        
//    } else {
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        
//        /*
//         let eventParams = []
//         eventParams will be from MainFeed.xib
//         (required) event_name, event_location, event_description, event_image
//         (optional) event_time, event_date, event_day
//         */
//        
//        
//    
//        
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        
//        [manager GET:@"https://nightout.herokuapp.com/api/v1/events?"
//          parameters:nil
//             success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                 NSLog(@"JSON: %@", responseObject);
//                 
//
//                 NSString *value = responseObject[@"events"][0][@"name"];
//                 NSLog(@"VALUE: %@", value);
//
//                 
//                 [self reloadBackgroundData];
//                 [self reloadForegroundDataOnCategory:self.selectedCategory];
//                 
//                 
//                 
//                 
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 NSLog(@"Error: %@", error);
//                 
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Event"
//                                                                     message:[error localizedDescription]
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"Ok"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//             }];
//    }
//}



- (void)categoryWillSet:(NSUInteger)currentCategory nextCategory:(NSUInteger)nextCategory
{
//    NSLog(@"categoryWillSet %lu %lu", (unsigned long)currentCategory, (unsigned long)nextCategory);
}

- (void)categoryDidSet:(NSUInteger)category
{
//    NSLog(@"categoryDidSet %lu", (unsigned long)category);
}

- (void)didSelectViewController:(PKContentViewController *)viewController
{
//    NSLog(@"didSelectViewController %@", viewController);
}

- (void)didEndTransitionAnimation:(BOOL)expand
{
//    NSLog(@"didEndTransitionAnimation %d", expand);
}



//- (NSInteger)backgroundCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//        // temporary
//        return [self.backgroundImages count];
//}


//- (UICollectionViewCell *)backgroundCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    EventFeedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventFeedCollectionViewCell" forIndexPath:indexPath];
//    
//    // Temporary
//    [cell.eventNameLabel setText:[NSString stringWithFormat:@"Feed %ld", (long)indexPath.row]];
//    [cell.eventLocationLabel setText:[NSString stringWithFormat:@"Location %ld", (long)indexPath.row]];
//    [cell.eventDescriptionLabel setText:[NSString stringWithFormat:@"Description %ld", (long)indexPath.row] ];
//    cell.eventImageView.image = [self.backgroundImages objectAtIndex:indexPath.row];
//
//    cell.backgroundColor = [UIColor darkGrayColor];
//    
////    UIView *mainFeedView = [[[NSBundle mainBundle] loadNibNamed:@"MainFeedView" owner:self options:nil] objectAtIndex:0];
////    cell.backgroundView = mainFeedView;
//
//    
////    NSDictionary *eventDictionary = nil;
////    
////    NSArray *upcomingEvents = [self.eventDict upcomingEvents];
////    eventDictionary = upcomingEvents[indexPath.row];
////    
////    cell.eventNameLabel.text = [eventDictionary name];
////    cell.eventDescriptionLabel.text = [eventDictionary description];
//
//        // Set Images using AFNetworking+UIImages (can try loading with Async Display also)
////    NSURL *url = [NSURL URLWithString:eventDictionary.image];
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];
////    UIImage *placeholderImage = [UIImage imageNamed:@"placeholderImage"];
////    
////    __weak MainFeedCollectionViewCell *weakCell = cell;
////    
////    [cell.mainFeedImageView setImageWithURLRequest:request
////                                  placeholderImage:placeholderImage
////                                           success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, UIImage * _Nonnull image) {
////                                               weakCell.mainFeedImageView.image = image;
////                                               [weakCell setNeedsLayout];
////    
////                                           } failure:nil];
//
//    
//
//    
//    
////    CGFloat color = floorf(indexPath.item)/[self backgroundCollectionView:collectionView numberOfItemsInSection:indexPath.section];
////    CGFloat saturation = floorf([[UIApplication sharedApplication].windows indexOfObject:(UIWindow *)self.view.superview])/[UIApplication sharedApplication].windows.count;
////
////    cell.backgroundColor = [UIColor colorWithHue:color saturation:saturation brightness:1 alpha:1];
//    
//
//    
//    //Tap on Event Feed (single tap)
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(handleSingleTap:)];
//    [cell addGestureRecognizer:singleFingerTap];
//
//    return cell;
//
//}
//
//// EventDetailVC Segue Tapped
//- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
//    
//    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
//    [self.navigationController presentViewController:controller animated:YES completion:nil];
//}




//- (UICollectionViewCell *)foregroundCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    FriendsGoingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"friendsGoingCollectionViewCell" forIndexPath:indexPath];
//    
//    
//    // Temporary
//    cell.friendsCoverPhoto.image = [UIImage imageNamed:@"demo"];
//    cell.backgroundColor = [UIColor darkGrayColor];
//    
//    return cell;
//    
//}

- (NSInteger)foregroundCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section onCategory:(NSInteger)category
{
    // Temporary
    return [self.backgroundImages count];
}

- (PKContentViewController *)foregroundCollectionView:(PKCollectionView *)collectionView contentViewControllerForAtIndexPath:(NSIndexPath *)indexPath onCategory:(NSUInteger)category
{
//    if (indexPath.section == 0) {
//        return [CollectionViewController new];
//    }
//    
//    if (indexPath.item % 3) {
//        return [ContentViewController new];
//    } else {
//        return [FullScreenContentViewController new];
//    }
    
        
//    if (indexPath.item) {
//        return [CardViewController new];
//
//    }
//
    
//    RKCardView* cardView = [[RKCardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [cardView.titleLabel setText:[NSString stringWithFormat:@"Friend %ld", (long)indexPath.row]];
    
    CardViewController *cardViewController = [CardViewController alloc];
    
    [cardViewController.titleLabel setText:[NSString stringWithFormat:@"Friend %ld", (long)indexPath.row]];
    
    //Tap on Friend Card
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(tapOnFriendCard:)];
//    [cardViewController.view addGestureRecognizer:singleFingerTap];

    
    NSLog(@"indexPath %@ cateogry %lu",indexPath, (unsigned long)category);
    return [CardViewController new];
}


    //Tap on Friend Card
//- (void)tapOnFriendCard:(UITapGestureRecognizer *)recognizer {
//    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondIdentityViewController"];
//    [self.navigationController presentViewController:controller animated:YES completion:nil];
//}




- (void)scrollView:(UIScrollView *)scrollView slideToAction:(PKCollectionViewControllerScrollDirection)direction;
{
    if (direction == PKCollectionViewControllerScrollDirectionPrevious) {
        
//        [self reloadBackgroundData];
//        [self reloadForegroundDataOnCategory:self.selectedCategory];
        
//        NSLog(@"PKCollectionViewControllerScrollDirectionPrevious");
    } else {
//        NSLog(@"PKCollectionViewControllerScrollDirectionNext");
    }
}

- (void)pullDownToActionWithProgress:(CGFloat)progress
{
    
}


@end
























