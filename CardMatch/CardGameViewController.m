//
//  CardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 2/28/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardGameViewController.h"
// #import "PlayingCardDeck.h" // this class is being made generic
#import "CardMatchingGame.h"
#import "GameResult.h"
// #import "GameSettings.h"

// we want our controller to provide data for the collection view
// so we will tell the world that the CardGameViewController is willing to be a colection view data source
@interface CardGameViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) BOOL animate; // Not really being used
@property (nonatomic) NSInteger itemToAnimate; // Not really being used
@property (nonatomic) NSInteger cellCount;
@property (nonatomic) BOOL removeUnplayableCards; // ADVICE: tells if an unplayable card should be removed


// UPGRADE
// An array of the cards on screen
// @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Bringing in the game itself, a pointer to the model
@property (strong, nonatomic) CardMatchingGame *game;

// A history of flips in the current game
@property (strong, nonatomic) NSMutableArray *history;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;

@property (weak, nonatomic) IBOutlet UISlider *historySlider;

@property (strong, nonatomic) GameResult *gameResult;

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;



@end


@implementation CardGameViewController


//-----------------------------------------------------------------
// Required Implementation for UICollectionViewDataSource Protocol
//-----------------------------------------------------------------

// optional example
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1; // returns 1 even if not implemented
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    // game knows the number of cards
    // game.cards is an array of cards
    
    //NSArray* sectionArray = [_data objectAtIndex:section];
    //return [sectionArray count];
    
    // gotta count items in cardCollectionView
    // cardCollectionView has one section with many items/cells/cards
    // cell = item
    //self.cardCollectionView
    
    
    // -*- -*- -*- -*- -*- -*- -*- -*- -*- -*-//
    // BHAlbum *album = self.albums[section];    
    // return album.photos.count;
    
    // return [self.game cardCount];
    return self.game.numberOfCards;
   
    
    // return self.startingCardCount; // *!* gonna want to ask how many cards are currently in play *!*
       //return [self collectionView:self.cardCollectionView numberOfItemsInSection:0]; infinite loop
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Everything works orginal
     
    //make sure "PlayingCard" matches up with what's in the storyboard (reuse identifier)
    // we're talking about the cell not the view within it
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingOrSetCard" forIndexPath:indexPath]; // PlayingOrSetCard has been set as the Reuse Identifier for both PlayingCardCollectionViewCell and PlayingCardCollectionViewCell
    
    NSLog(@"Cell #%d added", self.cellCount++);
    NSLog(@"cardCollectionView cell #%d", [self collectionView:self.cardCollectionView numberOfItemsInSection:0]);
    
    // now that we have the cell let's load it up with that something from the model
    // let's get that something from the model... the card
    Card *card = [self.game cardAtIndex:indexPath.item];
    // indexPath has two propertys item and section
    // the section will be 0 because we only have one section, while the item will be which card we're talking about
    
    //[self updateCell:cell usingCard:card];  // implemented just below
    [self updateCell:cell usingCard:card decideToAnimate:self.animate];
    
    return cell;
    
    
    
    /*
    // -----
    // let the below fail when the index is for a card that's unplayable
    
    // not quite there yet
    
    // -----
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingOrSetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    
    // Removing Matched Cards
    if (card.isUnplayable)
    {
       [self.game removeCardAtIndex:indexPath.item];
       [collectionView moveItemAtIndexPath:indexPath toIndexPath:nil];
    }
    
    else
    {
        [self updateCell:cell usingCard:card decideToAnimate:self.animate];
    }
    
    return cell;
    */
    
}


// supports method above
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card decideToAnimate:(BOOL)animate
{
    // abstract
    // can't be implemented in this base class because nothing is known about playing cards and set cards here
    // don't forget to make it public, so subclasses can make it not abstract 
}


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

/*
- (void)deleteItemsFromDataSourceAtIndexPaths:(NSArray *)indexPathArray
{
    NSLog(@"4) CGVC.m in deleteItemsFromDataSourceAtIndexPaths");
    [self.cardCollectionView deleteItemsAtIndexPaths:indexPathArray];
    
    // I should have done something that looks more like this line below
    // [self.cardCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
}

- (void)removeCell:(UICollectionViewCell *)cell //fromCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"3) CGVC.m in removeCell");
    
    //- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths
    
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
    NSArray *indexPathArray = [NSArray arrayWithObjects: indexPath, nil];
    
    // Adjust number of cards in data source?
    // self.startingCardCount--;
    
    // YES self is the datat source >> @interface CardGameViewController () <UICollectionViewDataSource>
    // But "deleteItemsFromDataSourceAtIndexPaths" is a made up method
    // Delete the items from the data source.
    [self deleteItemsFromDataSourceAtIndexPaths:indexPathArray];
    // [self.game removeCardAtIndex:indexPath.item];
    
    // Now delete the items from the collection view.
    [self.cardCollectionView deleteItemsAtIndexPaths:indexPathArray];
    
    // - (void) reloadData;
    // - (void) reloadItemsAtIndexPaths:(NSArray *)indexPaths;
    
    // [collectionView insertItemsAtIndexPaths:indexPathArray];
    
}
 
*/

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


//-----------------------------------------------------------------
// Original Implementation
//-----------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateUI];
}

// Lazy instantiation for the model
- (CardMatchingGame *)game
{
    if (!_game)
    {
        // will now be a generic base class
        // playing card and set will become sub classes
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[self createDeck]];
        [self gameModeChange:self.gameModeSelector];
    }
    
    return _game;
}

- (Deck*)createDeck { return nil; } //abstract

- (NSMutableArray *)history
{
    if (!_history)
    {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

// UPGRADE
/*
- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];    
}
 */

- (void)setGameModeSelector:(UISegmentedControl *)gameModeSelector
{
    _gameModeSelector = gameModeSelector;
    
    [self updateUI];
}

#define RESULTS_LABEL_FONT_SIZE 12.0

// The method to update the UI
// Objective 1: Make the UI look like the model
// Objective 2: Inform the model of changes to the UI
- (void)updateUI
{
    NSLog(@"2) CGVC.m in updateUI");
    
    
    // go through all the visible cells and  update them all
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        
        
        //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
        // Perhaps this is where cards are to be removed
        //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
        
        // get the indexPath for each one to find it in the model
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        
        Card *card = [self.game cardAtIndex:indexPath.item];
        
        
        
        // [self updateCell:cell usingCard:card];
        
        // USE ME
        [self updateCell:cell usingCard:card decideToAnimate:self.animate];

        
        
        //- (void)removeCell:(UICollectionViewCell *)cell fromCollectionView:(UICollectionView *)collectionView;
        /* // Removing Matched Cards
        if (card.isUnplayable)
        {
            
            [self removeCell:cell]; // fromCollectionView:self.cardCollectionView
            [self.game removeCardAtIndex:indexPath.item];
            
            [self.game removeCardAtIndex:i];
            [self.cardCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        
        else
        {
            [self updateCell:cell usingCard:card decideToAnimate:self.animate];
        }
        
        
        
        //--- The Old Way ---//
         if (card.isUnplayable)
         {
             //[self.cardCollectionView visibleCells]; // DELETE ITEM
             
             [self.game removeCardAtIndex:indexPath.item]; // DELETE ITEM
             
             
             // reduce number of cards on screen
             
             
             //[self updateCell:cell usingCard:card decideToAnimate:self.animate];
         }
         
         else
         {
             [self updateCell:cell usingCard:card decideToAnimate:self.animate];
         }
         */
        
        
        // if statement to control which card is flipped
        /* Use if using animate variable
         if (self.itemToAnimate == indexPath.item)
         {
         [self updateCell:cell usingCard:card decideToAnimate:!self.animate]; // yes animate
         }
         
         else
         {
         [self updateCell:cell usingCard:card decideToAnimate:self.animate];
         }
         */
    }
    
    // Make sure the enbled state is correct
    self.gameModeSelector.enabled = self.game.isActiveModeControl;

    // Update score on UI
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // Update results on UI  
    if ([self.game.results isKindOfClass: [NSAttributedString class]])
    {
        // Update results
        if (self.game.results) self.resultsLabel.attributedText = self.game.results;
        
        // Center and Set Font Size
        NSRange range = [[self.resultsLabel.attributedText string] rangeOfString:[self.resultsLabel.attributedText string]];
        
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        [paragrahStyle setAlignment: NSTextAlignmentCenter];
        
        NSMutableAttributedString *resultsLabelAttrText = [self.resultsLabel.attributedText mutableCopy];
        [resultsLabelAttrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:RESULTS_LABEL_FONT_SIZE] range:range];
        [resultsLabelAttrText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:range];
            
        self.resultsLabel.attributedText = resultsLabelAttrText;
    }
    
    else
    {
        self.resultsLabel.text = self.game.results;
    }
    
    self.resultsLabel.alpha = 1;
    
    // Update slider on UI
    [self updateSliderRange];
    
}

// Purely UI features can update themselves directly in their own setter
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (void)updateSliderRange
{
    int maxValue = [self.history count] - 1;
    if (maxValue < 0) maxValue = 0;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

// UPGRADE
// - (IBAction)flipCard:(UIButton *)sender

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    // get the location of the tap
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    
    // get the indexPath of the cell that was clicked on
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    // check to confirm tap is on a cell
    if (indexPath)
    {
        // all the former flipCard code
        
        // [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        // self.itemToAnimate = indexPath.item; // animate when flipped // Not necessary now
        NSLog(@"1) CGVC.m card succesfully flipped");
        
        
        // TROUBLE for SetCard
        
        // introspect to only work on playingcards
        // if statement is causing trouble
        
        /*
        if(![self.game.results isEqualToString:@"Results"] && ![[self.history lastObject] isEqualToString:self.game.results]) // *!* condition to keep word "Results" out of history
        {
            [self.history addObject:self.game.results];
        }
         */
       
        
        
        
        // Each time a card is flipped the UI needs to be updated
        [self updateUI];
        
        
        self.gameResult.score = self.game.score;
        
        self.gameResult.gameType = self.game.gameType;
        
        
    }
    
    // CARD REMOVAL
    if (self.removeUnplayableCards)
    {
        for (int i = 0; i < self.game.numberOfCards; i++)
        {
            Card *card = [self.game cardAtIndex:i];
            
            if (card.isUnplayable)
            {
                [self.game removeCardAtIndex:i];
                [self.cardCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
            }
        }
    }
    
}



- (IBAction)historySliderChanged:(UISlider *)sender
{
    int sliderValue;
    sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:NO];
    
    if ([self.history count])
    {
        self.resultsLabel.alpha =
        (sliderValue + 1 < [self.history count]) ? 0.6 : 1.0;
        self.resultsLabel.text = [self.history objectAtIndex:sliderValue];
    }
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0; // reset flipCount
    self.history = nil;
    self.gameResult =nil;
    [self updateUI]; // get all cards face up
}

- (IBAction)gameModeChange:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex])
    {
        case 0:
            self.game.numberOfMatchingCards = 2;
            break;
        case 1:
            self.game.numberOfMatchingCards = 3;
            break;
        default:
            self.game.numberOfMatchingCards = 2;
            break;
    }
}


@end
