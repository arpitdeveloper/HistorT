//
//  DataViewCell.h
//  HistorT
//
//  Created by Macbook Pro on 29/12/18.
//  Copyright © 2018 com. HistorT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataViewCell : UICollectionViewCell

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) IBOutlet UIView *viewCell;
@property (strong, nonatomic) IBOutlet UILabel *cellLabel;
@property (strong, nonatomic) IBOutlet UITextView *cellTextView;

@end

NS_ASSUME_NONNULL_END
