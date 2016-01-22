//
//  PlayerTableViewCell.h
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayerTableViewCellDelegate <NSObject>

@required

@optional

- (void) PlayerTableViewCellDelegate:(id)cell updatedName:(NSString *)name;

@end


@interface PlayerTableViewCell : UITableViewCell




@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;

@property (nonatomic, assign) id <PlayerTableViewCellDelegate> delegate;

@end
