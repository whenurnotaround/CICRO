//
//  Bubble.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/19/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class Tweet;

@interface Bubble : UIView {
	
	
	Tweet *myOwnViewController;
	NSString *tweet_msg;
	
	float _width;
	float _height;
	float _alpha;
	float _onFocusAlpha;
	UIColor *bubble_color;
	BOOL onFocus;
}

@property (retain, nonatomic) Tweet *myOwnViewController;
@property (retain, nonatomic) NSString *tweet_msg;
@property (assign) float _width;
@property (assign) float _height;
@property (assign) float _alpha;
@property (assign) BOOL onFocus;
@property (retain, nonatomic) UIColor *bubble_color;

- (id)initWithFrame:(CGRect)frame;
- (CGColorSpaceRef)getTheRGBColorSpace;
@end
