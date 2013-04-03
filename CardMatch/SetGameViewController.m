//
//  SetGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/26/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface SetGameViewController ()

// *** IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@property (nonatomic) int flipCount;

// An array of the cards on screen
// *** IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Bringing in the game itself, a pointer to the model
@property (strong, nonatomic) CardMatchingGame *game;

// A history of flips in the current game
@property (strong, nonatomic) NSMutableArray *history;

// *** IBOutlet UILabel *scoreLabel
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// *** IBOutlet UILabel *resultsLabel
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

// xxx IBOutlet UISegmentedControl *gameModeSelector;

// xxx IBOutlet UISlider *historySlider;

// @property (strong, nonatomic) GameResult *gameResult;

@end

@implementation SetGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        // --- get font size from resultsLabel -----------------------------------------------
        
        // Initialize fontSize
        CGFloat fontSize = [UIFont systemFontSize];
        
        // Must ask for current font size because font and size are package together,
        // but we only want to grab font from the button
        NSDictionary *attributes = [self.resultsLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
        
        // Looking up in the dictionary what the font is
        UIFont *existingFont = attributes[NSFontAttributeName];
        
        // If a font is found take font size by itself
        if (existingFont) fontSize = existingFont.pointSize;  // font size from label
        
        NSLog(@" ~ s.resultsLabel.attrText: %@", [self.resultsLabel.attributedText string]);
        NSLog(@" ~ existingFont.pointSize %f", existingFont.pointSize);
        
        // -----------------------------------------------------------------------------------
    

    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]];
        // [self gameModeChange:self.gameModeSelector];
    }
    return _game;
}

- (NSMutableArray *)history
{
    if (!_history)
    {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardshading.png"];
    
    for (UIButton *cardButton in self.cardButtons)
    {
        // Get a card from
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // Setting all of the card's features
        
        // NSLog(@"in updateUI card.contents %@", [card.contents string]);
        
        [cardButton setAttributedTitle:card.contents forState:UIControlStateNormal];
        [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected];
        [cardButton setBackgroundImage:cardBackImage forState:UIControlStateSelected];
        [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        [cardButton setBackgroundImage:cardBackImage forState:UIControlStateSelected | UIControlStateDisabled];
        
         
        // Make sure correct state is selected
        cardButton.selected = card.isFaceUp;
        
        // Make sure the enbled state is correct
        cardButton.enabled = !card.isUnplayable;
        
        // Ghost cards if matched to 30%
        cardButton.alpha = (card.isUnplayable ? 0.05 : 1.0);
        
        // Display the card back if the card is face down
        if (!card.isFaceUp)
        {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        
        else
        {
            [cardButton setBackgroundImage:cardBackImage forState:UIControlStateNormal]; // this made need changing
        }
    }
    
    // Update score on UI
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // Update results on UI
    if (self.resultsLabel.attributedText)
    {    
        // --- get font size from resultsLabel -----------------------------------------------
        
            // Initialize fontSize
            CGFloat fontSize = [UIFont systemFontSize];

            // Must ask for current font size because font and size are package together,
            // but we only want to grab font from the button
            NSDictionary *attributes = [self.resultsLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
            
            // Looking up in the dictionary what the font is
            UIFont *existingFont = attributes[NSFontAttributeName];
            
            // If a font is found take font size by itself
            if (existingFont) fontSize = existingFont.pointSize;  // font size from label
            
            NSLog(@"self.resultsLabel.attributedText: %@", [self.resultsLabel.attributedText string]);
            NSLog(@"existingFont.pointSize %f", existingFont.pointSize);
            
        // -----------------------------------------------------------------------------------
        
        // update results
        
        NSLog(@" A s.resultsLabel.attrText: %@", [self.resultsLabel.attributedText string]);
        NSLog(@" B existingFont.pointSize %f", existingFont.pointSize);
        
        if (self.game.results) self.resultsLabel.attributedText = self.game.results;
        
        //---
            NSLog(@" C s.resultsLabel.attrText: %@", [self.resultsLabel.attributedText string]);

            // --- get font size from resultsLabel -----------------------------------------------
            
                attributes = [self.resultsLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
                existingFont = attributes[NSFontAttributeName];
                if (existingFont) fontSize = existingFont.pointSize;  // font size from label
                NSLog(@" D existingFont.pointSize %f", existingFont.pointSize);

            // -----------------------------------------------------------------------------------
        //---
        
        
        // --- add attribute to range --------------------------------------------------------
        
            NSRange range = [[self.resultsLabel.attributedText string] rangeOfString:[self.resultsLabel.attributedText string]];
            
            // Assuming the range has been found
            if (range.location != NSNotFound)
            {
                // Get a mutable version of the string to work with
                NSMutableAttributedString *mat = [self.resultsLabel.attributedText mutableCopy];
                
                // Add attributes to the range of text
                [mat addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
                
                // Update the attributed text
                self.resultsLabel.attributedText = mat;
            }
        
        // -----------------------------------------------------------------------------------
        
        //---
            NSLog(@" E s.resultsLabel.attrText: %@", [self.resultsLabel.attributedText string]);
            
            // --- get font size from resultsLabel -----------------------------------------------
            
            attributes = [self.resultsLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
            existingFont = attributes[NSFontAttributeName];
            if (existingFont) fontSize = existingFont.pointSize;  // font size from label
            NSLog(@" F existingFont.pointSize %f", existingFont.pointSize);
            
            // -----------------------------------------------------------------------------------
        //---
        
        
        /*
        //Set font with font from button and size from label
        UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
        
        // Update label
        [self addSelectedWordAttributes:@{NSFontAttributeName : font}];
        
        
        
        
        addAttributes:range:
        
        */
            
        self.resultsLabel.alpha = 1;    
    }
    
    
    else
    {
        NSMutableAttributedString *bob = [[NSMutableAttributedString alloc] initWithString:@"Results"];
        self.resultsLabel.attributedText = [bob mutableCopy];
        
        NSLog(@" * else statement: %@", [bob string]);
        
        // --- setting font and size --------------------------------------------------------
        /*
            UIFont *font = [UIFont fontWithName:@"Palatino-Roman" size:14.0];
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                        forKey:NSFontAttributeName];
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"strigil" attributes:attrsDictionary];
        
        
        self.resultsLabel.attributedText = attrString;
        NSLog(@" * s.resultsLabel.attrText: %@", [self.resultsLabel.attributedText string]);
        */
        // -----------------------------------------------------------------------------------
        
    }
    
    
}

// Purely UI features can update themselves directly in their own setter
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    // self.resultsLabel.attributedText = self.game.results;
    
    /*
     
     // if (![[self.history lastObject] isEqualToString:self.game.results]) [self.history addObject:self.game.results];
     if(![self.game.results isEqualToString:@"Results"] && ![[self.history lastObject] isEqualToString:self.game.results]) // *!* condition to keep word "Results" out of history
     {
     [self.history addObject:self.game.results];
     }
     
     */
    
    // Each time a card is flipped the UI needs to be updated
    [self updateUI];
    // self.gameResult.score = self.game.score;
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0; // reset flipCount
    self.history = nil;
    self.resultsLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"Results"];
    // self.gameResult =nil;
    [self updateUI]; // get all cards face up
}


@end
