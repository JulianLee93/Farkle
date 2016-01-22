//
//  AddPlayerTableViewCell.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "AddPlayerTableViewCell.h"

@implementation AddPlayerTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)onAddPlayerButtonTapped:(UIButton *)sender {
    [self.delegate onAddPlayerButtonTapped:sender playerName:self.AddPlayerTextField.text];
}


@end
