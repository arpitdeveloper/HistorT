//
//  HistoryDocumentController.m
//  HistorT
//
//  Created by Macbook Pro on 05/01/19.
//  Copyright © 2019 com. HistorT. All rights reserved.
//

#import "HistoryDocumentController.h"
#import "DetailsController.h"
#import "ConstitutinoController.h"
#import <Firebase/Firebase.h>
@interface HistoryDocumentController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *historyNavigation;

@property (strong, nonatomic) IBOutlet UIScrollView *hisroyScrollView;
@property (strong, nonatomic) IBOutlet UIButton *declearBTN;
@property (strong, nonatomic) IBOutlet UIButton *usBTN;

@end

@implementation HistoryDocumentController

- (void)viewDidLoad {
    [super viewDidLoad];
    _historyNavigation.title = _navigationTitle;
    self.hisroyScrollView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self btnEditAction:_declearBTN];
    [self btnEditAction:_usBTN];
    
//FireBase Database---------------------------------------------------
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://histort-12563.firebaseio.com/"];
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSDictionary *tempDict = snapshot.value;
        NSDictionary *bookDict = [tempDict objectForKey:@"data "];
        NSDictionary *dictData = [bookDict objectForKey:@"declaration"];
        [self.declearBTN setTitle:[dictData valueForKey:@"label"] forState:UIControlStateNormal];
        NSDictionary *usDict = [bookDict objectForKey:@"usconstitution"];
        [self.usBTN setTitle:[usDict valueForKey:@"label"] forState:UIControlStateNormal];
        
    } withCancelBlock:^(NSError *error) {
        
        NSLog(@"%@", error.description);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)btnEditAction:(UIButton *)btn {

    btn.layer.borderWidth = 0.2;
    btn.layer.borderColor = [UIColor colorWithRed:127.0/255.0 green:86.0/255.0 blue:26.0/255.0 alpha:1.0].CGColor;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, self.view.frame.size.width - 56, 0, 0);

}
#pragma mark - Button Action

- (IBAction)declearAction:(id)sender {
    
    DetailsController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
    view.labelData = _declearBTN.titleLabel.text;
    [self.navigationController pushViewController:view animated:YES];
    
}
- (IBAction)usAction:(id)sender {
    
    ConstitutinoController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ConstitutinoController"];
    view.navigationTitle = _usBTN.titleLabel.text;
    [self.navigationController pushViewController:view animated:YES];
}

@end
