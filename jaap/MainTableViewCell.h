//
//  MainTableViewCell.h
//  jaap
//
//  Created by manoj sk on 8/12/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

-(void) initializeCell:(NSString*) label;
@end
