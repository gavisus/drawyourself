//
//  AZAppDelegate.h
//  drawyourself
//
//  Created by Jung Kim on 12. 10. 8..
//  Copyright (c) 2012년 AuroraPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZDrawView.h"

@class AZViewController;

@interface AZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) AZDrawView *aDrawView;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AZViewController *viewController;

@end
