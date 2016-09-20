//
//  PKWindow.m
//  PaperKit
//
//  Created by Norikazu on 2015/06/29.
//  Copyright © 2015年 Stamp inc. All rights reserved.
//

#import "PKWindow.h"
#import "PKPanGestureRecognizer.h"

@class PKViewController;
@interface PKWindow () <UIGestureRecognizerDelegate>

@property (nonatomic) PKPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) CGFloat statusBarHeight;
@property (nonatomic) BOOL linked;

@property (nonatomic) UIWindow *superWindow;
@property (nonatomic) PKWindow *childWindow;

@property (nonatomic) CGFloat upperProgress;
@property (nonatomic) CGFloat lowerProgress;
@property (nonatomic) CGFloat thresholdPosition;

@end

@implementation PKWindow
{
    BOOL _initialized;
    CGPoint _initialTouchPoint;
    CGPoint _initialTouchPosition;
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _initialized = NO;
    _state = PKWindowStateNormal;
    _interval = 60;
    _statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    _link = YES;
    _linked = YES;
    
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = YES;
    
    self.layer.cornerRadius = 4.0f;
    /*
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.25f;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    */
    self.windowLevel = UIWindowLevelStatusBar + 1;
    self.panGestureRecognizer = [[PKPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    self.panGestureRecognizer.scrollDirection = PKPanGestureRecognizerDirectionVertical;
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    self.tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)setState:(PKWindowState)state
{
    _state = state;
    if (state == PKWindowStateNormal) {
        self.rootViewController.view.userInteractionEnabled = YES;
    } else {
        self.rootViewController.view.userInteractionEnabled = NO;
    }
}

- (void)makeKeyAndVisible:(BOOL)animated
{

    [self.manager windowWillAppear:self];
    
    if (animated) {
        [super makeKeyAndVisible];
        [self setTransitionProgress:1];
        [self animationTransitionState:PKWindowStateNormal velocity:0];
    }
    else {
        [super makeKeyAndVisible];
        [self.manager windowDidAppear:self];
    }
}


- (BOOL)hasManyWindows
{
    return 1 < [self.manager windowsOnBaseWindow].count;
}

- (NSArray *)childWindows
{
    NSArray *windows = [self.manager windowsOnBaseWindow];
    NSMutableArray *childWindows = @[].mutableCopy;
    [windows enumerateObjectsUsingBlock:^(UIWindow *window, NSUInteger idx, BOOL * __nonnull stop) {
        if (window.windowLevel > self.windowLevel) {
            [childWindows addObject:window];
        }
    }];
    return childWindows;
}

- (UIWindow *)parentWindow
{
    NSArray *windows = [self.manager windowsOnBaseWindow];
    NSInteger index = [windows indexOfObject:self];
    if (index) {
        UIWindow *parentWindow = nil;
        while (parentWindow == nil) {
            UIWindow *window = windows[index - 1];
            if (window.windowLevel == UIWindowLevelNormal) {
                parentWindow = window;
            }
            index --;
        }
        
        return parentWindow;
    }
    return nil;
}

- (UIWindow *)superWindow
{
    NSArray *windows = [self.manager windowsOnBaseWindow];
    NSInteger index = [windows indexOfObject:self];
    if (index) {
        PKWindow *superWindow = windows[index - 1];
        if (superWindow) {
            return superWindow;
        }
    }
    return nil;
}

- (PKWindow *)childWindow
{
    NSArray *windows = [self.manager windowsOnBaseWindow];
    NSInteger index = [windows indexOfObject:self];
    if (index < windows.count - 1) {
        PKWindow *superWindow = windows[index + 1];
        if (superWindow) {
            return superWindow;
        }
    }
    return nil;
}

- (NSArray *)_windows
{
    return [self.manager windowsOnBaseWindow];
}

- (CGFloat)progressToListState
{
    NSInteger count = [self _windows].count - 1;
    CGFloat height = _statusBarHeight + _interval * count;
    return height / [UIScreen mainScreen].bounds.size.height;
}

- (CGFloat)upperProgress
{
    return [self progressToListState] + 0.08;// + _statusBarHeight/[UIScreen mainScreen].bounds.size.height;
}

- (CGFloat)lowerProgress
{
    return [self progressToListState];// + _statusBarHeight/[UIScreen mainScreen].bounds.size.height;
}

- (CGFloat)thresholdPosition
{
    return [self positionForProgress:self.upperProgress];
}

- (void)setLink:(BOOL)link
{
    [self setLink:link animated:NO];
}

- (void)setLink:(BOOL)link animated:(BOOL)animated
{
    if (_link != link) {
        _link = link;
        if (!link) {
            _linked = link;
        }
        if (animated) {
            [self animationWithLink:link];
        } else {
            _linked = link;
        }
    }
}

- (void)setGlobalProgress:(CGFloat)globalProgress
{
    _globalProgress = globalProgress;
    
    // Progress chain
    if ([[self superWindow] isKindOfClass:[PKWindow class]]) {
        ((PKWindow *)[self superWindow]).globalProgress = globalProgress;
    }
    
    if (globalProgress <= self.upperProgress) {
        if (self.linked) {
            [self _setTransitionProgress:globalProgress];
        }
    }
    
    [self setLink:(globalProgress <= self.upperProgress) animated:YES];
    
}

- (void)_setTransitionProgress:(CGFloat)transitionProgress
{
    _transitionProgress = transitionProgress;
    
    if (self.globalProgress <= transitionProgress) {
        [self pop_removeAnimationForKey:@"inc.stamp.pk.window.link"];
        _link = YES;
        _linked = YES;
    }
    
    if (0 == transitionProgress) {
        self.state = PKWindowStateNormal;
    } else if(transitionProgress < self.upperProgress) {
        self.state = PKWindowStateList;
    } else {
        self.state = PKWindowStateNormal;
    }
    
    CGFloat yPosition = [self positionForProgress:transitionProgress];
    POPLayerSetTranslationY(self.layer, yPosition);
    
    if (self.linked) {
        NSArray *windows = [self _windows];
        NSInteger i = windows.count - 1 - [windows indexOfObject:self];
        
        CGFloat scale = POPTransition(transitionProgress/self.lowerProgress, 1 - i * 0.01 , 1);
        scale = MIN(scale, 1);
        POPLayerSetScaleXY(self.layer, CGPointMake(scale, scale));
    }
}

- (void)setTransitionProgress:(CGFloat)transitionProgress
{
    _transitionProgress = transitionProgress;
    if ([[self superWindow] isKindOfClass:[PKWindow class]]) {
        ((PKWindow *)[self superWindow]).globalProgress = transitionProgress;
    }
    CGFloat yPosition = [self positionForProgress:transitionProgress];
    POPLayerSetTranslationY(self.layer, yPosition);
}

- (CGFloat)positionForProgress:(CGFloat)transitionProgress
{
    NSArray *windows = [self _windows];
    CGFloat progress = transitionProgress/[self progressToListState];
    NSUInteger i = [windows indexOfObject:self];
    return POPTransition(transitionProgress, 0, [UIScreen mainScreen].bounds.size.height) - POPTransition(progress, 0, _interval * (windows.count - 1 - i));
}

- (void)dissmis
{
    if (self.manager) {
        [self.manager windowDidDisappear:self];
    }
}

#pragma mark - TapGestureRecognizer

- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    [self setLink:NO animated:NO];
    [self.childWindow _animationTransitionState:PKWindowStateDismiss velocity:0];
    [self animationTransitionState:PKWindowStateNormal velocity:0];
}

#pragma mark - PanGestureRecognizer

- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self];
    CGPoint translation = [recognizer translationInView:self];
    CGPoint velocity = [recognizer velocityInView:self];

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            _initialTouchPoint = location;
            _initialTouchPosition = self.frame.origin;
        
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat yPosition = _initialTouchPosition.y + translation.y;
            CGFloat x = yPosition/[UIScreen mainScreen].bounds.size.height;
            CGFloat y = x;
            CGFloat lower = self.lowerProgress;
            CGFloat upper = self.upperProgress;

            CGFloat k = 5;
            
            if (x < 0) {
                y = x/8;
            }
            
            if (0 <= x && x < lower) {
                y = x;
            }
            
            if (lower <= x && x < upper) {
                y = 1/k * x + lower * (1 - 1/k);
            }
            
            if (upper <= x) {
                y = x + (1/k - 1) * (upper - lower);
            }
            
            [self setTransitionProgress:y];
        
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
    
            PKWindowState state = PKWindowStateNormal;
            if (velocity.y > 0) {
                if ([self hasManyWindows]) {
                    
                    if ([self progressToListState] < self.transitionProgress) {
                        state = PKWindowStateDismiss;
                    } else {
                        state = PKWindowStateList;
                    }
                    
                } else {
                    state = PKWindowStateOpen;
                }
            } else {
                if ([self hasManyWindows]) {
                    if ([self progressToListState] < self.transitionProgress) {
                        state = PKWindowStateList;
                    } else {
                        state = PKWindowStateNormal;
                    }
                } else {
                    state = PKWindowStateNormal;
                }
            }
            
            [self animationTransitionState:state velocity:velocity.y];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - Animation

- (void)animationWithLink:(BOOL)link
{
    POPBasicAnimation *animation = [self pop_animationForKey:@"inc.stamp.pk.window.link"];
    if (!animation) {
        animation = [POPBasicAnimation animation];
        POPAnimatableProperty *propX = [POPAnimatableProperty propertyWithName:@"inc.stamp.pk.property.window.link" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(id obj, CGFloat values[]) {
                values[0] = [obj transitionProgress];
            };
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                [obj _setTransitionProgress:values[0]];
            };
            prop.threshold = 0.01;
        }];
        animation.property = propX;
        animation.duration = 0.3;
        animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished) {
                if (self.globalProgress <= self.upperProgress) {
                    [self setLink:YES];
                } else {
                    [self setLink:NO];
                }
            }
        };
        [self pop_addAnimation:animation forKey:@"inc.stamp.pk.window.link"];
    }
    animation.toValue = link ? @(self.globalProgress): @(0);
}

- (void)animationTransitionState:(PKWindowState)state velocity:(CGFloat)velocity
{
    self.state = state;
    POPSpringAnimation *animation = [self pop_animationForKey:@"inc.stamp.pk.window.progress"];
    if (!animation) {
        animation = [POPSpringAnimation animation];
        POPAnimatableProperty *propX = [POPAnimatableProperty propertyWithName:@"inc.stamp.pk.property.window.progress" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(id obj, CGFloat values[]) {
                values[0] = [obj transitionProgress];
            };
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                [obj setTransitionProgress:values[0]];
            };
            prop.threshold = 0.01;
        }];
        //animation.velocity = @(velocity/1000);
        animation.property = propX;
        animation.springSpeed = 8;
        animation.dynamicsTension = 450;
        animation.dynamicsFriction = 33;
        animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished) {
                if (state == PKWindowStateDismiss) {
                    [self dissmis];
                }
                if (state == PKWindowStateNormal) {
                    [self setLink:YES animated:NO];
                    if (!_initialized) {
                        _initialized = YES;
                        [self.manager windowDidAppear:self];
                    }
                }
                if (state == PKWindowStateList) {
                    [self setLink:YES animated:NO];
                }
                
            }
        };
        [self pop_addAnimation:animation forKey:@"inc.stamp.pk.window.progress"];
    }
    
    switch (state) {
        case PKWindowStateList:
            animation.toValue = @(self.lowerProgress);
            break;
        case PKWindowStateOpen:
            animation.toValue = @(0.9);
            break;
        case PKWindowStateDismiss:
            animation.toValue = @(1);
            break;
        case PKWindowStateNormal:
        default:
            animation.toValue = @(0);
            break;
    }
}

- (void)_animationTransitionState:(PKWindowState)state velocity:(CGFloat)velocity
{
    self.state = state;
    [self.childWindow _animationTransitionState:state velocity:velocity];
    POPSpringAnimation *animation = [self pop_animationForKey:@"inc.stamp.pk.window.progress"];
    if (!animation) {
        animation = [POPSpringAnimation animation];
        POPAnimatableProperty *propX = [POPAnimatableProperty propertyWithName:@"inc.stamp.pk.property.window.progress" initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(id obj, CGFloat values[]) {
                values[0] = [obj transitionProgress];
            };
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                [obj _setTransitionProgress:values[0]];
            };
            prop.threshold = 0.01;
        }];
        //animation.velocity = @(velocity/1000);
        animation.property = propX;
        animation.springSpeed = 8;
        animation.dynamicsTension = 450;
        animation.dynamicsFriction = 33;
        animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished) {
                if (state == PKWindowStateDismiss) {
                    [self dissmis];
                }
                if (state == PKWindowStateNormal) {
                    [self setLink:YES animated:NO];
                }
                if (state == PKWindowStateList) {
                    [self setLink:YES animated:NO];
                }
            }
        };
        [self pop_addAnimation:animation forKey:@"inc.stamp.pk.window.progress"];
    }
    
    switch (state) {
        case PKWindowStateList:
            animation.toValue = @(self.lowerProgress);
            break;
        case PKWindowStateOpen:
            animation.toValue = @(0.9);
            break;
        case PKWindowStateDismiss:
            animation.toValue = @(1);
            break;
        case PKWindowStateNormal:
        default:
            animation.toValue = @(0);
            break;
    }
}

#pragma mark - Gesture delegate

- (BOOL)gestureRecognizerShouldBegin:(nonnull UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.tapGestureRecognizer) {
        if (self.state == PKWindowStateOpen || self.state == PKWindowStateList) {
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark - Utilities

static inline CGFloat POPTransition(CGFloat progress, CGFloat startValue, CGFloat endValue) {
    return startValue + (progress * (endValue - startValue));
}

@end