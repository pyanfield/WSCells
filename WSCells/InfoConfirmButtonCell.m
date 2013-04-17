//
//  InfoConfirmButtonCell.m
//  Sporttipassi
//
//  Created by Weishuai Han on 4/15/13.
//  Copyright (c) 2013 Sporttipassi. All rights reserved.
//

#import "InfoConfirmButtonCell.h"
#import "CellGradientLayer.h"

@implementation InfoConfirmButtonCell

+ (Class)layerClass
{
    return [CellGradientLayer class];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor =  [UIColor colorWithWhite:0.05 alpha:1.0];
        self.textLabel.shadowColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        self.textLabel.highlightedTextColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        self.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    }
    return self;
}

@end
