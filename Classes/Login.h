//
//  Login.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/31/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Login : UIView {
	IBOutlet UITextField *usernameTextField;
	IBOutlet UITextField *passwordTextField;
	IBOutlet UIButton *loginBtn;
	IBOutlet UILabel *caution;
}

@property (retain, nonatomic) IBOutlet UITextField *usernameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginBtn;
@property (retain, nonatomic) IBOutlet UILabel *caution;

@end
