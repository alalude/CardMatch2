//
//  SetCardView.h
//  SpecialCard
//
//  Created by Akinbiyi Lalude on 4/20/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) CGFloat shade;
@property (strong, nonatomic) UIColor *color;

@property (nonatomic) BOOL faceUp;

@end
