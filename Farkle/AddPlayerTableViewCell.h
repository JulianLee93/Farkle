//
//  AddPlayerTableViewCell.h
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddPlayerTableViewCellDelegate <NSObject>

@required

@optional

- (void) onAddPlayerButtonTapped:(UIButton *)sender playerName:(NSString *)name;
-(void) onNewPlayerTextFieldUpdated:(NSString *)name;

@end

@interface AddPlayerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *AddPlayerTextField;

@property (nonatomic, assign) id <AddPlayerTableViewCellDelegate> delegate;

@end
