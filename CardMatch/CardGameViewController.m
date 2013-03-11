//
//  CardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 2/28/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//// add a deck property
@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    //// this needs to be a new random card each click
    //// leverage -- UIButton - setTitle:forState
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
//    if (sender.isSelected)
//    {
//        sender.selected = NO;
//        else
//        {
//            sender.selected = YES;
//        }
//        
//    }
    
    sender.selected = !sender.isSelected;
    
//    self.flipCount = self.flipCount + 1;
    
    self.flipCount++;
}

@end
