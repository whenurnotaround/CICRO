//
//  Bubble.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/19/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "Bubble.h"
#import "Tweet.h"
#import "ViewHelpers.h"

static int TweetMsgLabelTag = 101;

@implementation Bubble

@synthesize tweet_msg, _width, _height, _alpha, onFocus, bubble_color, myOwnViewController;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		//[self setBackgroundColor:[UIColor whiteColor]];
		[self setBackgroundColor:[UIColor clearColor]];
		
		// view instance
		_width = self.frame.size.width;
		_height = self.frame.size.height;
		
		// default focus alpha
		_alpha = 0.5;
		
		// on fucus alpha
		_onFocusAlpha = 0.9;
		
		// default value = false
		onFocus = FALSE;
		
		// default color
		bubble_color = [UIColor whiteColor];
		
		// setup GestureRecognizer
		UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc]
													initWithTarget:self action:@selector(handleSingleDoubleTap:)];
		singleFingerDTap.numberOfTapsRequired = 2;
		[self addGestureRecognizer:singleFingerDTap];
		[singleFingerDTap release];
		
		
    }
    return self;
}

- (void)handleSingleDoubleTap:(UIGestureRecognizer *)sender {
    NSLog(@"double tab");
	
	[myOwnViewController switchBubbleToNormalView];
}


#pragma mark Draw Methods
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
	[super drawRect:rect];
	
	// set size
	//[self setFrame:CGRectMake(self.center.x, self.center.y, _width, _height)];
	
	
	// draw circle
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextBeginPath(ctx);
	CGContextSetLineWidth(ctx, 1);
	CGContextAddArc(ctx, _width/2, _width/2, _width/2, 0, 2*M_PI, 0);
	CGContextSetFillColorWithColor(ctx, [bubble_color CGColor]);
	CGContextFillPath(ctx);
	CGContextStrokePath(ctx);
	
	
	
	// set fill color
	if (onFocus)
		[self setAlpha:_onFocusAlpha];
	else 
		[self setAlpha:_alpha];	
	
	// draw label
	[self drawUILabel];
	

	
	
}

- (void)drawUILabel {
	
	// check if there is existing lable
	[ViewHelpers removeView:TweetMsgLabelTag FromSuperView:self];
	
	// draw label
	UIFont *font = [UIFont fontWithName:@"Marker Felt" size:28];
	
	int label_size = round(sqrt(pow(_width, 2)/2));
	
	// fixed blur
	if (label_size%2 != 0) {
		label_size += 1;
	}
	
	// init label to fit inside buble 
	UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake((round(_width - label_size)/2), round((_width - label_size)/2), label_size, label_size)];
	[text setTag:TweetMsgLabelTag];
	
	// Transparent background color
	[text setBackgroundColor:[UIColor clearColor]];
	
	// Set Text Alignment to be center
	[text setTextAlignment:UITextAlignmentCenter];
	
	int i;
	/* Time to calculate the needed font size.
	 This for loop starts at the largest font size, and decreases by two point sizes (i=i-2)
	 Until it either hits a size that will fit or hits the minimum size we want to allow (i > 10) */
	for(i = 28; i > 5; i=i-2)
	{
		// Set the new font size.
		font = [font fontWithSize:i];
		// You can log the size you're trying: 
		
		/* This step is important: We make a constraint box 
		 using only the fixed WIDTH of the UILabel. The height will
		 be checked later. */ 
		CGSize constraintSize = CGSizeMake(label_size, MAXFLOAT);
		
		// This step checks how tall the label would be with the desired font.
		CGSize labelSize = [tweet_msg sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
		
		/* Here is where you use the height requirement!
		 Set the value in the if statement to the height of your UILabel
		 If the label fits into your required height, it will break the loop
		 and use that font size. */
		if(labelSize.height <= label_size)
			break;
	}
	// You can see what size the function is using by outputting: NSLog(@"Best size is: %u", i);
	
	// Set the UILabel's font to the newly adjusted font.
	text.font = font;
	
	// Set label to multiline with word wrap
	text.lineBreakMode = UILineBreakModeWordWrap;
	// = 0 is let system calculate how many line?
	text.numberOfLines = 0;
	
	// Put the text into the UILabel outlet variable.
	[text setText:tweet_msg];
	
	[self addSubview:text];
	
	[text release];
}

#pragma mark Interaction Methods
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	
	[self setOnFocus:TRUE];
	[self setNeedsDisplay];
} 

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.superview];
	self.center = location;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
	[self setOnFocus:FALSE];
	[self setNeedsDisplay];
}


- (void)dealloc {
	[myOwnViewController release];
	[tweet_msg release];
	[bubble_color release];
    [super dealloc];
}


@end
