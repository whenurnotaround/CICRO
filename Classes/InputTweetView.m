//
//  InputTweetView.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/27/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "InputTweetView.h"


@implementation InputTweetView

@synthesize inputTweetTextView, tweetBtn;
@synthesize _status;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		
	// default status on HIDE	
		_status = 0;
		
		
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	[super drawRect:rect];
	
	inputTweetTextView.layer.borderWidth = 1.0f;
	inputTweetTextView.layer.cornerRadius = 8;
	inputTweetTextView.layer.borderColor = [[UIColor blackColor] CGColor];
	
	//Get the CGContext from this view
	//CGContextRef context = UIGraphicsGetCurrentContext();
//	//Set the stroke (pen) color
//	CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//	//Set the width of the pen mark
//	CGContextSetLineWidth(context, 5.0);
//	
//	CGContextAddRect(context, CGRectMake(18.0, 62.0, 988.0, 106.0));
//	
//	CGContextFillPath(context);
}


- (void)dealloc {
    [super dealloc];
}


@end
