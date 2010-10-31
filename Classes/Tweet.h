//
//  Tweet.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/28/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CICROViewController;
@class Bubble, NormalView, ViewHelpers;

@interface Tweet : UIViewController {
	
	CICROViewController *cicroViewController;
	NSDictionary *tweet;
	
	UIView *tweetsGround;
	
	Bubble *bubble;
	IBOutlet NormalView *normalView;
}

@property(retain, nonatomic)CICROViewController *cicroViewController;
@property(retain, nonatomic)NSDictionary *tweet;
@property(retain, nonatomic)UIView *tweetsGround;
@property(retain, nonatomic)Bubble *bubble;
@property(retain, nonatomic)IBOutlet NormalView *normalView;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cicroViewController:(CICROViewController *)cicroController tweetObject:(NSDictionary *)tweetObject andTweetsGround:(UIView *)ground;
-(void)switchBubbleToNormalView;
-(void)switchNormalViewToBubble;
@end
