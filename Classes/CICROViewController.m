//
//  CICROViewController.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/18/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "CICROViewController.h"
#import "ViewHelpers.h"

// Views
#import "Bubble.h"
#import "Tweet.h"
#import "InputTweetView.h"
#import "TweetsGround.h"
#import "Login.h"

@implementation CICROViewController

@synthesize inputTweetView, tweetsGround, loginView;
@synthesize tweets, tweetViews;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)setTextForTweetTextInputView:(NSString *)text{
	[inputTweetView.inputTweetTextView setText:text];
}

#pragma mark Handle Action From Outlets
-(IBAction)Login {
	NSString *consumerKey = @"NPskewpj5P5E3bdb9xdAg";
	NSString *consumerSecret = @"glIVh7z0zzlk6jSmKtc6FyDFNDrH8qx4OLgGekpxU";
	
	NSString *username = loginView.usernameTextField.text;
    NSString *password = loginView.passwordTextField.text;
	
	NSLog(@"username = %@", username);
	NSLog(@"password = %@", password);	
	twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
	
	[twitterEngine setUsesSecureConnection:NO];
	[twitterEngine setConsumerKey:consumerKey secret:consumerSecret];
	
	[twitterEngine getXAuthAccessTokenForUsername:username password:password];
}

- (IBAction)handleShowOrHideTweetForm {
	if (inputTweetView._status == 0) {
		[UIView beginAnimations:@"showAnimation" context:NULL];
		[UIView setAnimationDuration:1.0];
		[inputTweetView setFrame:CGRectMake(0, 0, inputTweetView.frame.size.width, inputTweetView.frame.size.height)];
		[UIView commitAnimations];
		[inputTweetView set_status:1];
	} else {
		[UIView beginAnimations:@"showAnimation" context:NULL];
		[UIView setAnimationDuration:1.0];
		[inputTweetView setFrame:CGRectMake(0, -265, inputTweetView.frame.size.width, inputTweetView.frame.size.height)];
		[UIView commitAnimations];
		[inputTweetView set_status:0];
	}

	
}

- (IBAction)tweetMsg {
	
	NSLog(@"%@", inputTweetView.inputTweetTextView.text);
	
	
	
	// create bubble
	// Location needs to be random for now..
	if ([inputTweetView.inputTweetTextView hasText]) {

		//update on Twitter
		[twitterEngine sendUpdate:inputTweetView.inputTweetTextView.text];
		// generate bubble
		//[self generateBubble:inputTweetView.inputTweetTextView.text];
		// reset TextView
		[inputTweetView.inputTweetTextView setText:@""];
		
		[inputTweetView.inputTweetTextView resignFirstResponder];
		
		// recalculate Alpha
		[ViewHelpers reCalculateAlphaForAllBubbles:tweetViews];
		[ViewHelpers reCalculateSizeForAllBubbles:tweetViews];
		
		// hide inputTweetView
		[self handleShowOrHideTweetForm];
	}
	
	
}

- (void)retweet:(long)tweetID {
	[twitterEngine sendRetweet:tweetID];
}

-(void)generateBubble:(NSDictionary *)tweetObject {
	
	Tweet *tweet = [[Tweet alloc] initWithNibName:@"Tweet" bundle:nil cicroViewController:self tweetObject:tweetObject andTweetsGround:tweetsGround];
	[self.tweetsGround addSubview:tweet.view];
	[tweetViews addObject:tweet];
	
	
	
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

#pragma mark UIViewController Delegates

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"load view");
	
	tweetViews = [[NSMutableArray alloc] init];
	
	[loginView.usernameTextField setText:@"whenurnotaround"];
	[loginView.passwordTextField setText:@"redpig6"];
	
	[super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[twitterEngine release];
	[inputTweetView release];
	[tweetsGround release];
	[tweets release];
	[tweetViews release];
    [super dealloc];
}

#pragma mark MGTwitterEngineDelegate methods


- (void)requestSucceeded:(NSString *)connectionIdentifier
{
    NSLog(@"Request succeeded for connectionIdentifier = %@", connectionIdentifier);
}


- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
    NSLog(@"Request failed for connectionIdentifier = %@, error = %@ (%@)", 
          connectionIdentifier, 
          [error localizedDescription], 
          [error userInfo]);
	[loginView.caution setHidden:NO];
	[loginView.caution setText:@"Wrong username & password"];
}

#pragma mark MGTwitterEngineDelegate Methods

- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got statuses for %@:\r%@", connectionIdentifier, statuses);
	
	self.tweets = statuses;
	
	// generate bubbles from twitter
	for (int row = 0; row < [self.tweets count]; row++) {
		[self generateBubble:[self.tweets objectAtIndex:row]];
	}
	
	// recalculate alpha
	[ViewHelpers reCalculateAlphaForAllBubbles:tweetViews];
	[ViewHelpers reCalculateSizeForAllBubbles:tweetViews];
	
	// hide loading label
	[tweetsGround.loadingLabel setHidden:YES];
	
	
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got direct messages for %@:\r%@", connectionIdentifier, messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got user info for %@:\r%@", connectionIdentifier, userInfo);
}


- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got misc info for %@:\r%@", connectionIdentifier, miscInfo);
}


- (void)searchResultsReceived:(NSArray *)searchResults forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got search results for %@:\r%@", connectionIdentifier, searchResults);
}


- (void)socialGraphInfoReceived:(NSArray *)socialGraphInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got social graph results for %@:\r%@", connectionIdentifier, socialGraphInfo);
}

- (void)userListsReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got user lists for %@:\r%@", connectionIdentifier, userInfo);
}

- (void)connectionFinished:(NSString *)connectionIdentifier
{
    NSLog(@"Connection finished %@", connectionIdentifier);
	
	if ([twitterEngine numberOfConnections] == 0)
	{
		//[NSApp terminate:self];
	}
}

- (void)accessTokenReceived:(OAToken *)aToken forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Access token received! %@",aToken);
	
	token = [aToken retain];
	[twitterEngine setAccessToken:token];
	NSLog(@"getHomeTimelineFor: connectionIdentifier = %@", [twitterEngine getHomeTimelineSinceID:0 startingAtPage:0 count:50]);
	[loginView removeFromSuperview];
	
	
	
}

@end
