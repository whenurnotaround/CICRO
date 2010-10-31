//
//  untitled.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/31/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "NormalView.h"
#import "ViewHelpers.h"

static int TweetMsgLabelTag = 101;
static int DisplayImageTag = 102;
static int ScreenNameTag = 103;
static int DescriptionTag = 104;
static int SwitchViewBtnTag = 105;

static int ReplyBtnTag = 201;

@implementation NormalView
@synthesize myOwnViewController ,displayImagePath, name, tweetMsg, description, switchViewBtn;
@synthesize replyBtnPath;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		
		UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc]
													initWithTarget:self action:@selector(switchView:)];
		singleFingerDTap.numberOfTapsRequired = 2;
		[self addGestureRecognizer:singleFingerDTap];
		[singleFingerDTap release];
		
		[self drawOptionButtons];	
    }
    return self;
}

#pragma mark Drawing
- (void)drawRect:(CGRect)rect {
    // Drawing code 
	
	[self drawTweetMsgLabel];
	[self drawScreenNameLabel];
	[self drawDisplayImageView];

	
}

- (void)drawDisplayImageView {
	[ViewHelpers removeView:DisplayImageTag FromSuperView:self];

	NSURL *url = [NSURL URLWithString:displayImagePath];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *image = [[UIImage alloc] initWithData:data];
	
	UIImageView *displayImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 48, 48)];
	[displayImgView setImage:image];
	[image release];
	
	[self addSubview:displayImgView];
	[displayImgView release];
}

- (void)drawScreenNameLabel {
	[ViewHelpers removeView:ScreenNameTag FromSuperView:self];
	
	UILabel *screenNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, 53, 40)];
	[screenNameLabel setTag:ScreenNameTag];
	
	[screenNameLabel setBackgroundColor:[UIColor clearColor]];
	
	// Set Text Alignment to be center
	[screenNameLabel setTextAlignment:UITextAlignmentCenter];
	[screenNameLabel setLineBreakMode:UILineBreakModeCharacterWrap];
	[screenNameLabel setNumberOfLines:0];
	[screenNameLabel setText:name];
	[screenNameLabel setFont:[UIFont fontWithName:@"Courier" size:12]];
	
	[self addSubview:screenNameLabel];
	[screenNameLabel release];
}

 
- (void)drawTweetMsgLabel {
	
	// check if there is existing lable
	[ViewHelpers removeView:TweetMsgLabelTag FromSuperView:self];
	
	// init label to fit inside buble 
	UILabel *tweetMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 210, 90)];
	[tweetMsgLabel setTag:TweetMsgLabelTag];
	
	[tweetMsgLabel setBackgroundColor:[UIColor whiteColor]];
	
	// Set Text Alignment to be center
	[tweetMsgLabel setTextAlignment:UITextAlignmentLeft];
	[tweetMsgLabel setLineBreakMode:UILineBreakModeWordWrap];
	[tweetMsgLabel setNumberOfLines:0];
	[tweetMsgLabel setText:tweetMsg];
	[tweetMsgLabel setFont:[UIFont fontWithName:@"Courier" size:12]];
	
	[self addSubview:tweetMsgLabel];
	
	[tweetMsgLabel release];
	
}

- (void)drawOptionButtons {
	
	//[ViewHelpers removeView:ReplyBtnTag FromSuperView:self];
	
	// frame
	UIImageView *optionBtnsFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"optionButtonsFrame.png"]];
	optionBtnsFrame.frame = CGRectMake(288, 0, 30, 120);
	[self addSubview:optionBtnsFrame];
	[optionBtnsFrame release];
	
	// reply button
	UIButton *replyBtn = [[UIButton alloc] initWithFrame:CGRectMake(288, 0, 30, 30)];
	[replyBtn setImage:[UIImage imageNamed:@"replyBtn.png"] forState:UIControlStateNormal];
	[replyBtn addTarget:myOwnViewController action:@selector(replyBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:replyBtn];
	[replyBtn release];
	
	// retweet button
	UIButton *reTweetBtn = [[UIButton alloc] initWithFrame:CGRectMake(288, 30, 30, 30)];
	[reTweetBtn setImage:[UIImage imageNamed:@"reTweetBtn.png"] forState:UIControlStateNormal];
	[reTweetBtn addTarget:myOwnViewController action:@selector(reTweetBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:reTweetBtn];
	[reTweetBtn release];
	
	// favorite button
	UIButton *favoriteBtn = [[UIButton alloc] initWithFrame:CGRectMake(288, 60, 30, 30)];
	[favoriteBtn setImage:[UIImage imageNamed:@"favoriteBtn.png"] forState:UIControlStateNormal];
	[favoriteBtn addTarget:myOwnViewController action:@selector(favoriteBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:favoriteBtn];
	[favoriteBtn release];
	
	// option button
	UIButton *optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(288, 90, 30, 30)];
	[optionBtn setImage:[UIImage imageNamed:@"optionBtn.png"] forState:UIControlStateNormal];
	[optionBtn addTarget:myOwnViewController action:@selector(optionBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:optionBtn];
	[optionBtn release];
}

#pragma mark Interaction Methods
-(IBAction)switchView:(UIGestureRecognizer *)sender {
	
	NSLog(@"switch view");
	[myOwnViewController switchNormalViewToBubble];
}

#pragma mark Interaction Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.superview];
	self.center = location;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesEnded");
}


- (void)dealloc {
	[myOwnViewController release];
    [super dealloc];
}


@end
