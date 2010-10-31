//
//  ViewHelpers.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/27/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "ViewHelpers.h"
#import "Bubble.h"

@implementation ViewHelpers

- (id)init {
    if ((self = [super init])) {

    }
    return self;
}

+(void)reCalculateAlphaForAllBubbles:(NSMutableArray *)tweets {
	
	// print size of bubbles
	[self printBubblesSize:tweets];
	
	// set instance needed for alpha.
	float _maxAlpha = 0.8;
	float _alphaGap = _maxAlpha / tweets.count;
	
	for (int i = 0; i < tweets.count; i++) {
		
		Bubble *bubble = [[tweets objectAtIndex:i] bubble];
		[bubble set_alpha:(i + 1) * _alphaGap];
		[bubble setNeedsDisplay];
		//NSLog(@"new allpha of %i = %f", i+1, [bubble _alpha]);
		
	}
}

+(void)reCalculateSizeForAllBubbles:(NSMutableArray *)tweets {
	
	// print size of bubbles
	[self printBubblesSize:tweets];
	
	// set instance needed for size
	float _maxSize = 200.0;
	float _minSize = 50.0;
	float _sizeGap = 2.0; // can not be odd number otherwise the view will get blur :(
	float _size = _maxSize;
	for (int i = tweets.count; i > 0; i--) {
		
		Bubble *bubble = [[tweets objectAtIndex:i - 1] bubble];
		
		if (_size > _minSize){
			[bubble set_width:_size];
			[bubble set_height:_size];
			_size -= _sizeGap;
		}	
		else{
			[bubble set_width:_minSize];
			[bubble set_height:_minSize];
		}
		
		//NSLog(@"size = %f", _size);
		
		[bubble setFrame:CGRectMake(bubble.frame.origin.x, bubble.frame.origin.y, bubble._width, bubble._height)];
		[bubble setNeedsDisplay];
		
		
	}
	
}

+(int)getRandomXfromView:(UIView *)view {
	int _minX = 0;
	int _maxX = view.frame.size.width;
	
	return (int)_minX + arc4random() % (_maxX - _minX + 1);
}
+(int)getRandomYfromView:(UIView *)view{
	int _minY = 0;
	int _maxY = view.frame.size.height;

	return (int)_minY + arc4random() % (_maxY - _minY + 1);	
}

+(UIColor *)randomColor {
	CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;	
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (void)removeView:(int)viewTag FromSuperView:(UIView *)superView {
	UIView *view;
	if (view = [superView viewWithTag:viewTag]) {
		[view removeFromSuperview];
	}
}

+(void)printBubblesSize:(NSMutableArray *)bubbles {

	NSLog(@"%i bubbles will be recalculated", [bubbles count]);
	
}


@end
