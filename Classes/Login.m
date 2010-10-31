//
//  Login.m
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/31/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import "Login.h"


@implementation Login
@synthesize usernameTextField, passwordTextField, loginBtn, caution;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
