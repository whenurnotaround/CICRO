//
//  InputTweetView.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/27/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface InputTweetView : UIView {

	// Outlet Instances
	IBOutlet UITextView *inputTweetTextView;
	IBOutlet UIButton *tweetBtn;
	
	int _status;
}

@property (retain, nonatomic) IBOutlet UITextView *inputTweetTextView;
@property (retain, nonatomic) IBOutlet UIButton *tweetBtn;
@property (assign) int _status;


@end
