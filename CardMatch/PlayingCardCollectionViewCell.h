//
//  PlayingCardCollectionViewCell.h
//  CardMatch
//
//  Created by Akinbiyi Lalude on 4/19/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h" 

@interface PlayingCardCollectionViewCell : UICollectionViewCell

// this is being made public because the controller needs to be able to access it
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
