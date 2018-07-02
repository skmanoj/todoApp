//
//  MainTableViewCell.m
//  jaap
//
//  Created by manoj sk on 8/12/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initializeCell:(NSString*) label
{
	[[self cellLabel] setText:label];
}
@end
