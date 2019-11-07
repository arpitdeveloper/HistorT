//
//  AllViewCell.h
//  HistorT
//
//  Created by Macbook Pro on 01/01/19.
//  Copyright © 2019 com. HistorT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *articleNameLB;
@property (strong, nonatomic) IBOutlet UILabel *numberLB;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLB;

@end

NS_ASSUME_NONNULL_END
