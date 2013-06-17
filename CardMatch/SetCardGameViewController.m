//
//  SetCardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 4/21/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardCollectionViewCell.h"

//--------------------------------//
// No Private Interface Necessary //
//--------------------------------//

@implementation SetCardGameViewController

#define STARTING_CARD_COUNT 16
#define PLAYABLE_CARD_ALPHA 1.0
#define UNPLAYABLE_CARD_ALPHA 0.3

- (Deck*)createDeck
{
    return [[SetCardDeck alloc] init];
}

// Make this a getter
// @property (nonatomic) NSUInteger startingCardCount
- (NSUInteger)startingCardCount
{
    return STARTING_CARD_COUNT;
}

// for removal of cards in set game only
- (BOOL)removeUnplayableCards
{
    return YES;
}


- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card decideToAnimate:(BOOL)animate
{
    //NSLog(@"1) SCGVC.m updateCell leads here");
    
    // this method can only handle cells of type SetCardCollectionViewCell
    // so introspection is to confirm compatibility
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]])
    {
        // confirmation is important because we need to get access to the SetCardView
        // it should contain
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        
        //now we must also confirm the card is a playing card
        if ([card isKindOfClass:[SetCard class]])
        {
            SetCard *setCard = (SetCard *)card;
            
            setCardView.suit = [setCard.rawContents objectForKey: @"suit"];
            setCardView.rank = [[setCard.rawContents objectForKey: @"rank"] intValue];
            setCardView.color = [setCard.rawContents objectForKey: @"color"];
            setCardView.shade = [[setCard.rawContents objectForKey: @"shade"] floatValue];
            setCardView.faceUp = setCard.isFaceUp;
            setCardView.alpha = setCard.isUnplayable ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
            
            
            //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
            /// Perhaps this is where cards are to be removed
            ////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
            
            
            // UIViewAnimationOptionTransitionFlipFromLeft
            // TransitionCurlUp
            // TransitionCrossDissolve
            
            /*
            if (setCard.isUnplayable)
            {
                // remove it from the array and view
                // Card *card = [self.game cardAtIndex:indexPath.item];
                // [self.game removeCardAtIndex:indexPath.item];
                
                [UIView transitionWithView : setCardView
                                  duration : 0.5
                                   options : UIViewAnimationOptionTransitionFlipFromLeft
                                animations : ^{
                                    // if (!self.setCardView.faceUp) [self drawRandomSetCard];
                                    // self.setCardView.faceUp = !self.setCardView.faceUp;
                                    setCardView.faceUp = setCard.isFaceUp;
                                }
                                completion : NULL];
            }
            
            else
            {
                setCardView.alpha = PLAYABLE_CARD_ALPHA;
            }
             */
            
            
            // -- Testing Suite -- //
            // NSLog(@" - SCGVC.m suit %@", setCardView.suit);
            // NSLog(@" - SCGVC.m rank %d", setCardView.rank);
            // NSLog(@" - SCGVC.m color %@", setCardView.color);
            // NSLog(@" - SCGVC.m shade %f", setCardView.shade);
             
        }
    }
}

@end

// Default Junk

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 }
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 */