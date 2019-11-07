//
//  TextPageController.m
//  HistorT
//
//  Created by Macbook Pro on 28/12/18.
//  Copyright © 2018 com. HistorT. All rights reserved.
//

#import "TextPageController.h"
#import "DetailsController.h"
@interface TextPageController ()

@property (strong, nonatomic) IBOutlet UITextView *txView;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationTitle;

@end

@implementation TextPageController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Design Here------------------------------------------------------------
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    self.navigationItem.title = _titleName;
    _txView.backgroundColor = [UIColor clearColor];
    

}
- (void) backToRootView:(id)sender {
    
    [self popVC];
    
     [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.txView setContentOffset:CGPointZero animated:NO];
    [self.navigationController setNavigationBarHidden:NO];

}

- (void) popVC {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFromTop;
    transition.subtype = kCATransitionPush;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
