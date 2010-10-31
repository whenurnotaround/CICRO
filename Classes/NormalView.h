//
//  untitled.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/31/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tweet;

@interface NormalView : UIView {
	Tweet *myOwnViewController;
	
	NSString *displayImagePath;
	NSString *name;
	NSString *tweetMsg;
	NSString *description;
	NSString *switchViewBtn;
	
	NSString *replyBtnPath;

}

@property (retain, nonatomic) Tweet *myOwnViewController;

@property(retain, nonatomic)NSString *displayImagePath;
@property(retain, nonatomic)NSString *name;
@property(retain, nonatomic)NSString *tweetMsg;
@property(retain, nonatomic)NSString *description;
@property(retain, nonatomic)NSString *switchViewBtn;

@property(retain, nonatomic)NSString *replyBtnPath;

-(IBAction)switchView:(UIGestureRecognizer *)sender;

@end
