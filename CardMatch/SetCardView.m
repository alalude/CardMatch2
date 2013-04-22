//
//  SetCardView.m
//  SpecialCard
//
//  Created by Akinbiyi Lalude on 4/20/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView ()

@property (nonatomic) CGRect rectA;
@property (nonatomic) CGRect rectB;
@property (nonatomic) CGRect rectC;
@property (nonatomic) CGRect rectD;
@property (nonatomic) CGRect rectE;

@end

@implementation SetCardView

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

- (void)setShade:(CGFloat)shade
{
    _shade = shade;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay]; // redraws any changes
}

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

#define CARD_CORNER_RADIUS 12.0

- (void)drawRect:(CGRect)rect
{
    self.rectA = CGRectMake((self.bounds.size.width * 0.025), (self.bounds.size.height * 0.200), (self.bounds.size.width * 0.300), (self.bounds.size.height * 0.600));
    self.rectB = CGRectMake((self.bounds.size.width * 0.350), (self.bounds.size.height * 0.200), (self.bounds.size.width * 0.300), (self.bounds.size.height * 0.600));
    self.rectC = CGRectMake((self.bounds.size.width * 0.675), (self.bounds.size.height * 0.200), (self.bounds.size.width * 0.300), (self.bounds.size.height * 0.600));
    
    self.rectD = CGRectMake((self.bounds.size.width * 0.175), (self.bounds.size.height * 0.200), (self.bounds.size.width * 0.300), (self.bounds.size.height * 0.600));
    self.rectE = CGRectMake((self.bounds.size.width * 0.525), (self.bounds.size.height * 0.200), (self.bounds.size.width * 0.300), (self.bounds.size.height * 0.600));
    
    
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
        // need to change background color
        [[UIColor lightGrayColor] setFill];
        UIRectFill(self.bounds);
        
        [self drawSetCard: self.suit: self.rank: self.shade : self.color];
    }
    
    else
    {
        // draw cardback
        // [[UIImage imageNamed:@"cardback.png"] drawInRect:self.bounds];
        [self drawSetCard: self.suit: self.rank: self.shade : self.color];
    }
}

- (void)shadeShape : (UIColor *)color
{
    UIBezierPath *shadePath = [[UIBezierPath alloc] init];
    
    for (CGFloat linePoint = 0; linePoint < 2; linePoint += 0.080)
    {
        [shadePath moveToPoint:CGPointMake((self.bounds.size.width * 0.000), (self.bounds.size.height * linePoint))];
        [shadePath addLineToPoint:CGPointMake((self.bounds.size.width * linePoint), (self.bounds.size.height * 0.000))];
    }
    
    [color setStroke];
    [shadePath stroke];
}

// -- Universal Drawer -- 

// @[@"▲"squiggle, @"●"oval, @"■"diamond];

- (void)drawSetCard : (NSString *)suit : (NSUInteger)rank : (CGFloat)shade : (UIColor *)color
{
    UIBezierPath *shapePath = [[UIBezierPath alloc] init];
    
    // Draw Shapes
    if (rank > 2) // Three
    {
        shapePath = [self drawOneShape: suit: self.rectA];
        [shapePath appendPath:[self drawOneShape: suit: self.rectB]];
        [shapePath appendPath:[self drawOneShape: suit: self.rectC]];
    }
    
    else if (rank > 1) // Two
    {
        shapePath = [self drawOneShape: suit: self.rectD];
        [shapePath appendPath:[self drawOneShape: suit: self.rectE]];
    }
    
    else // One
    {
        shapePath = [self drawOneShape: suit: self.rectB];
    }
    
    [shapePath addClip];
    
    [color setStroke];
    [shapePath stroke];
    
    // Shade Shapes
    if (shade >= 1) // Three
    {
        [color setFill];
        [shapePath fill];
    }
    
    else if (shade > 0) // Two
    {
        [self shadeShape: color];
    }
    
    else // One
    {
        // do nothing
    }
}
 
- (UIBezierPath *)drawOneShape : (NSString *)suit : (CGRect)newBounds
{
    UIBezierPath *oneShapePath = [[UIBezierPath alloc] init];

    CGFloat widthStart = newBounds.origin.x;
    CGFloat heightStart = newBounds.origin.y;
    CGFloat shapeWidth = newBounds.size.width;
    CGFloat shapeHeight = newBounds.size.height;

    if ([suit isEqualToString: @"▲"]) //squiggle
    {     
         [oneShapePath addArcWithCenter:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.200)))
                                 radius:(shapeHeight * 0.100)
                             startAngle:(1.5 * M_PI)
                               endAngle:(0.5 * M_PI)
                              clockwise:YES];
         [oneShapePath addArcWithCenter:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.350)))
                                 radius:(shapeHeight * 0.050)
                             startAngle:(1.5 * M_PI)
                               endAngle:(0.5 * M_PI)
                              clockwise:NO];
         [oneShapePath addArcWithCenter:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.650)))
                                 radius:(shapeHeight * 0.250)
                             startAngle:(1.5 * M_PI)
                               endAngle:(0.5 * M_PI)
                              clockwise:YES];
         
         [oneShapePath addArcWithCenter:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.800)))
                                 radius:(shapeHeight * 0.100)
                             startAngle:(0.5 * M_PI)
                               endAngle:(1.5 * M_PI)
                              clockwise:YES];
         [oneShapePath addArcWithCenter:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.650)))
                                 radius:(shapeHeight * 0.050)
                             startAngle:(0.5 * M_PI)
                               endAngle:(1.5 * M_PI)
                              clockwise:NO];
         [oneShapePath addArcWithCenter:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.350)))
                                 radius:(shapeHeight * 0.250)
                             startAngle:(0.5 * M_PI)
                               endAngle:(1.5 * M_PI)
                              clockwise:YES];
    }

    if ([suit isEqualToString: @"■"]) //diamond
    {
         [oneShapePath moveToPoint:CGPointMake((widthStart + (shapeWidth * 0.000)), (heightStart + (shapeHeight * 0.500)))];
         [oneShapePath addLineToPoint:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 1.000)))];
         [oneShapePath addLineToPoint:CGPointMake((widthStart + (shapeWidth * 1.000)), (heightStart + (shapeHeight * 0.500)))];
         [oneShapePath addLineToPoint:CGPointMake((widthStart + (shapeWidth * 0.500)), (heightStart + (shapeHeight * 0.000)))];
         [oneShapePath closePath];
    }

    if ([suit isEqualToString: @"●"]) // oval
    {
         oneShapePath = [UIBezierPath bezierPathWithOvalInRect:newBounds];
    }

    return oneShapePath;
 
}
 
@end