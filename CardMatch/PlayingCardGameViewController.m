//
//  PlayingCardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 4/19/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@interface PlayingCardGameViewController ()
@end

@implementation PlayingCardGameViewController

#define STARTING_CARD_COUNT 22
#define PLAYABLE_CARD_ALPHA 1.0
#define UNPLAYABLE_CARD_ALPHA 0.3

- (Deck*)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

// transform this property into its getter
// @property (nonatomic) NSUInteger startingCardCount
- (NSUInteger)startingCardCount
{
    return STARTING_CARD_COUNT;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card decideToAnimate:(BOOL)animate
{
    //NSLog(@"animate: %d", animate);
    
    // confirm cell is of type UICollectionViewCell
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]])
    {
        // accessing outlet of little box to get the playing card view
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        
        /*
        if ([card isKindOfClass:[PlayingCard class]])
        {
            // -*- former updateUI code -*- //
            
            // -*- animation goes here -*- //
            
            PlayingCard *playingCard = (PlayingCard *)card;
            
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
            
        }
        */
        
         
        if ([card isKindOfClass:[PlayingCard class]])
        {
            // -*- former updateUI code -*- //
            
            PlayingCard *playingCard = (PlayingCard *)card;
            
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            
            //if (animate || (playingCardView.faceUp > playingCard.isFaceUp)) // This, my original way also works
            if (playingCardView.faceUp != playingCard.isFaceUp)
            {
                [UIView transitionWithView : playingCardView
                              duration : 0.5
                               options : UIViewAnimationOptionTransitionFlipFromLeft
                            animations : ^{
                                // if (!self.setCardView.faceUp) [self drawRandomSetCard];
                                // self.setCardView.faceUp = !self.setCardView.faceUp;
                                playingCardView.faceUp = playingCard.isFaceUp;
                            }
                            completion : NULL];
            }
            
            else
            {
                playingCardView.faceUp = playingCard.isFaceUp;
            }
            
            playingCardView.alpha = playingCard.isUnplayable ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
            
        }
        
    }
}

@end
