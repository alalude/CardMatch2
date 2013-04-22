//
//  PlayingCardView.h
//  SpecialCard
//
//  Created by Akinbiyi Lalude on 4/9/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic) BOOL faceUp;

// a public method the playing card will provide
- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
