//
//  PlayerTableViewCell.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "PlayerTableViewCell.h"

@interface PlayerTableViewCell () <UITextFieldDelegate>

@end

@implementation PlayerTableViewCell

- (void)awakeFromNib {
    self.playerNameTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *updatedName = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self.delegate PlayerTableViewCellDelegate:self updatedName:updatedName];
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}





@end
