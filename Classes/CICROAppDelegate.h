//
//  CICROAppDelegate.h
//  CICRO
//
//  Created by Yongpisanpop Papon on 10/18/10.
//  Copyright 2010 NAIST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CICROViewController;
//@class LoginViewController;

@interface CICROAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CICROViewController *viewController;
	//LoginViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CICROViewController *viewController;
//@property (nonatomic, retain) IBOutlet LoginViewController *viewController;

@end

