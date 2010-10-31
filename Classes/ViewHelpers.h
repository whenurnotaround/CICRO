//
//  ViewHelpers.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/27/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Bubble;

@interface ViewHelpers : NSObject {

}

+ (void)reCalculateAlphaForAllBubbles:(NSMutableArray *)tweets;
+ (void)reCalculateSizeForAllBubbles:(NSMutableArray *)tweets;
+ (int)getRandomXfromView:(UIView *)view;
+ (int)getRandomYfromView:(UIView *)view;
+ (UIColor *)randomColor;
+ (void)removeView:(int)viewTag FromSuperView:(UIView *)superView;

+(void)printBubblesSize:(NSMutableArray *)bubbles;

@end
 