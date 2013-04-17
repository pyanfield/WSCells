//
//  InfoConfirmButtonCell.h
//  Sporttipassi
//
//  Created by Weishuai Han on 4/15/13.
//  Copyright (c) 2013 Sporttipassi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ButtonAdd,
    ButtonDelete
} ButtonType;

@interface InfoConfirmButtonCell : UITableViewCell

@property (nonatomic) ButtonType accessoryBtnType;
@property (nonatomic, strong) UIButton *accessoryBtn;

@end
