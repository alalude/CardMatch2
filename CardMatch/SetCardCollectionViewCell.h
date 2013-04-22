//
//  SetCardCollectionViewCell.h
//  CardMatch
//
//  Created by Akinbiyi Lalude on 4/21/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardCollectionViewCell : UICollectionViewCell

// NOTE this outlet is from the SetCardView not SetCardCollectionViewCell
// This is public because the controller needs to access
// Now any time i have a little box I can gt the playing card view out of it using this outlet
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end
