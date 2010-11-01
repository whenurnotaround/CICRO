//
//  CICROViewController.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/18/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTwitterEngine.h"

// Twitter
@class OAToken;

// Views
@class ViewHelpers;
@class Bubble;
@class Tweet;
@class InputTweetView;
@class TweetsGround;
@class Login;



@interface CICROViewController : UIViewController <MGTwitterEngineDelegate>{
	
	// Twitter Instances
	MGTwitterEngine *twitterEngine;
	OAToken *token;
	
	// Views
	IBOutlet InputTweetView *inputTweetView;
	IBOutlet TweetsGround *tweetsGround;
	IBOutlet Login *loginView;
	
	// Data 
	NSArray *tweets;
	NSMutableArray *tweetViews;
	
	//user
	NSString *username;
	
	
}

@property(retain, nonatomic)IBOutlet InputTweetView *inputTweetView;
@property(retain, nonatomic)IBOutlet TweetsGround *tweetsGround;
@property(retain, nonatomic)IBOutlet Login *loginView;

@property(retain, nonatomic)NSArray *tweets;
@property(retain, nonatomic)NSMutableArray *tweetViews;

@property (retain, nonatomic)NSString *username;

- (IBAction)Login;
- (IBAction)tweetMsg;
- (void)retweet:(long)tweetID;
- (IBAction)handleShowOrHideTweetForm;
- (void)generateBubble:(NSDictionary *)tweet_object;
- (void)setTextForTweetTextInputView:(NSString *)text;

@end

