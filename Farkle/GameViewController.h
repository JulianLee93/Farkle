//
//  GameViewController.h
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerViewController.h"

@interface GameViewController : UIViewController

@property NSMutableArray *playersArray;
@property NSUInteger gameScoreLimit;
@property PlayerViewController *pvc;

@end
