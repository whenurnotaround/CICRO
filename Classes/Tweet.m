//
//  Tweet.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/28/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "CICROViewController.h"
#import "Tweet.h"
#import "Bubble.h"
#import "ViewHelpers.h"
#import "NormalView.h"

static int NormalViewWidth = 318;
static int NormalViewHeight = 120;

@implementation Tweet

@synthesize cicroViewController;
@synthesize tweet;
@synthesize tweetsGround, bubble, normalView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cicroViewController:(CICROViewController *)cicroController tweetObject:(NSDictionary *)tweetObject andTweetsGround:(UIView *)ground {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
		// set Cicro View Controller
		self.cicroViewController = cicroController;
		
		// set Tweet info
		self.tweet = tweetObject;
		
		// set TweetsGround 
		self.tweetsGround = ground;
    }
    return self;
}


-(void)loadView {
	// create bubble
	bubble = [[Bubble alloc] initWithFrame:CGRectMake([ViewHelpers getRandomXfromView:tweetsGround], [ViewHelpers getRandomYfromView:tweetsGround], 120, 120)];
	[bubble setTweet_msg:[tweet objectForKey:@"text"]];
	[bubble setBubble_color:[ViewHelpers randomColor]];
	[bubble setMyOwnViewController:self];
	[self setView:bubble];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
}

-(void)switchBubbleToNormalView {
	//306 89
	if (normalView == nil) {
		normalView = [[NormalView alloc] initWithFrame:CGRectMake(round(self.view.frame.origin.x), round(self.view.frame.origin.y), NormalViewWidth, NormalViewHeight)];
		
		// set properties for normalView
		[normalView setTweetMsg:[tweet objectForKey:@"text"]];
		[normalView setDisplayImagePath:[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"]];
		[normalView setName:[[tweet objectForKey:@"user"] objectForKey:@"screen_name"]];
		[normalView setReplyBtnPath:@"replyBtn.png"];
		[normalView setMyOwnViewController:self];
		
		[self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, NormalViewWidth, NormalViewHeight)];
		[normalView setBackgroundColor:bubble.bubble_color];
		[self setView:normalView];
		
	} else {
		[self.view setFrame:CGRectMake(bubble.frame.origin.x, bubble.frame.origin.y, NormalViewWidth, NormalViewHeight)];
		[self setView:normalView];
	}
	
}

-(void)switchNormalViewToBubble {
	
	if (bubble != nil) {
		[self.view setFrame:CGRectMake(normalView.frame.origin.x, normalView.frame.origin.y, bubble._width, bubble._height)];
		[self setView:bubble];
	}
}

-(void)replyBtnHandler:(id)sender {
		
	//[cicroViewController.inputTweetView.inputTweetTextView setText:@"reply"];
	NSString *text = [NSString stringWithFormat:@"%@%@ ", @"@",[[tweet objectForKey:@"user"] objectForKey:@"screen_name"]];
	[text stringByAppendingString:@" "];
	[cicroViewController setTextForTweetTextInputView:text];
	[cicroViewController handleShowOrHideTweetForm];
}

-(void)reTweetBtnHandler:(id)sender {
	
	// retweet
	[cicroViewController retweet:(long)[tweet objectForKey:@"id"]];
	NSLog(@"retweet");
}

-(void)favoriteBtnHandler:(id)sender {
	
	// retweet
}

-(void)optionBtnHandler:(id)sender {
	
	// more option
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[tweetsGround release];
	[bubble release];
	[tweet release];
    [super dealloc];
}


@end
