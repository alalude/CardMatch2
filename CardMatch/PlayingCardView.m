//
//  PlayingCardView.m
//  SpecialCard
//
//  Created by Akinbiyi Lalude on 4/9/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;

@end


@implementation PlayingCardView

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90


    - (CGFloat)faceCardScaleFactor
    {
        if (!_faceCardScaleFactor)
        {
            _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
        }
        
        return _faceCardScaleFactor;
    }

    - (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
    {
        _faceCardScaleFactor = faceCardScaleFactor;
        [self setNeedsDisplay];
    }

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay]; // redraws any changes
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay]; // redraws any changes
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay]; // redraws any changes
}

#pragma mark - Initialization

- (void)setup
{
    // do initialization here
}

// need this because UIView is inited differently than UIViewControllers/storyboard objects
- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded))
    {
        // adjust scale of picture relative to the size of the pinch
        self.faceCardScaleFactor *= gesture.scale;
        
        // reset gesture scale to 1 one so that the image is always being incrementally resized
        gesture.scale = 1;
    }
}

#define CARD_CORNER_RADIUS 12.0
#define SUIT_RANK_FONT_RATIO 0.20
#define CORNER_TEXT_PADDING 2.0

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Card's Background: rounded rect, white bckgrnd, thin blk line
    
    // Card that fully fills bounds
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect: self.bounds cornerRadius: CARD_CORNER_RADIUS];
    
    // clip to rect to assure all drawing is limited to its interior
    [roundedRect addClip];
    
    // area within bounds is transparent, put area within rect is filled white, so corners remain rounded
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    // black boarder
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    
    if (self.faceUp)
    {    
        // attempt to get facecard graphics
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png", [self rankAsString], self.suit]];
        
        // if ther are face graphics draw them 
        if (faceImage)
        {
            NSLog(@"Card Image: %@%@", [self rankAsString], self.suit);
            // create an appropriately sized rect to put image in
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor), self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            
            // drawInRectScales image to fit in rect
            [faceImage drawInRect:imageRect];
        }
        
        else
        {
            NSLog(@"No Card Image: %@%@", [self rankAsString], self.suit);
            [self drawPips];
        }
        
        // coding style - don't clutter methods
        [self drawCorners];
    }
    
    else
    {
        // draw cardback
        [[UIImage imageNamed:@"cardback.png"] drawInRect:self.bounds];
    }
}

- (NSString *)rankAsString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"] [self.rank];
}
#pragma mark - Pips

    #define PIP_FONT_SCALE_FACTOR 0.20
    #define PIP_HOFFSET_PERCENTAGE 0.165
    #define PIP_VOFFSET1_PERCENTAGE 0.090
    #define PIP_VOFFSET2_PERCENTAGE 0.175
    #define PIP_VOFFSET3_PERCENTAGE 0.270

    - (void)drawPips
    {
        if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3))
        {
            [self drawPipsWithHorizontalOffset:0
                                verticalOffset:0
                            mirroredVertically:NO];
        }
        
        if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8))
        {
            [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                                verticalOffset:0
                            mirroredVertically:NO];
        }
        
        if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10))
        {
            [self drawPipsWithHorizontalOffset:0
                                verticalOffset:PIP_VOFFSET2_PERCENTAGE
                            mirroredVertically:(self.rank != 7)];
        }
        
        if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10))
        {
            [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                                verticalOffset:PIP_VOFFSET3_PERCENTAGE
                            mirroredVertically:YES];
        }
        
        if ((self.rank == 9) || (self.rank == 10))
        {
            [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                                verticalOffset:PIP_VOFFSET1_PERCENTAGE
                            mirroredVertically:YES];
        }
    }

    - (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                          verticalOffset:(CGFloat)voffset
                              upsideDown:(BOOL)upsideDown
    {
        if (upsideDown) [self pushContextAndRotateUpsideDown];
        
        CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
        NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName : pipFont}];
        CGSize pipSize = attributedSuit.size;
        CGPoint pipOrigin = CGPointMake(
                                        middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                        middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                        );
        [attributedSuit drawAtPoint:pipOrigin];
        
        if (hoffset)
        {
            pipOrigin.x += hoffset*2.0*self.bounds.size.width;
            [attributedSuit drawAtPoint:pipOrigin];
        }
        
        if (upsideDown) [self popContext];
    }

    - (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                          verticalOffset:(CGFloat)voffset
                      mirroredVertically:(BOOL)mirroredVertically
    {
        [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
        
        if (mirroredVertically)
        {
            [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
        }
    }

- (void)drawCorners
{
    // text of rank over suit to sit in card's corner
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // rank and suit centered horizontally
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    // Use system font and size it relative to the card
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * SUIT_RANK_FONT_RATIO];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{ NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : cornerFont }];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake(CORNER_TEXT_PADDING, CORNER_TEXT_PADDING);
    
    // ask the cornerText what size rect it needs
    textBounds.size = [cornerText size];
    
    // draw text within rect
    [cornerText drawInRect:textBounds];
    
    // change context
    [self pushContextAndRotateUpsideDown];
    
    // redraw cornerText now in oposite corner
    [cornerText drawInRect:textBounds];
    
    // return context to normal
    [self popContext]; 
}

- (void) pushContextAndRotateUpsideDown
{
    // current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // save/push the current context
    CGContextSaveGState(context);
    
    // translate context transformation matrix
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height); // translate down to lower right-hand corner
    
    // rotate context 180˚
    CGContextRotateCTM(context, M_PI); // Pi radians = 180˚
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}











@end
