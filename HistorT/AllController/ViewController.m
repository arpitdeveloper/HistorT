//
//  ViewController.m
//  HistorT
//
//  Created by Macbook Pro on 28/12/18.
//  Copyright © 2018 com. HistorT. All rights reserved.
//

#import "ViewController.h"
#import "DetailsController.h"
#import "HistoryDocumentController.h"
#import "ArticleController.h"
#import <Firebase/Firebase.h>
@interface ViewController ()
{
    NSString *declData;
    NSString *usdictdata;
}
@property (strong, nonatomic) IBOutlet UIButton *historBTN;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) IBOutlet UIButton *historyDocBTN;
@property (strong, nonatomic) IBOutlet UIButton *fourmulaBTN;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Design Here---------------------------------------------------------------
    _logoImageView.hidden = YES;
    _historBTN.hidden = NO;
    
    [self btnEditAction:_historyDocBTN hidden:YES];
    [self btnEditAction:_fourmulaBTN hidden:YES];
    _historyDocBTN.imageEdgeInsets = UIEdgeInsetsMake(0, self.view.frame.size.width - 56, 0, 0);
    _fourmulaBTN.imageEdgeInsets = UIEdgeInsetsMake(0, self.view.frame.size.width - 56, 0, 0);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];

}

-(void)btnEditAction:(UIButton *)btn hidden:(BOOL)hide{
    
    btn.layer.borderWidth = 0.2;
    btn.layer.borderColor = [UIColor colorWithRed:127.0/255.0 green:86.0/255.0 blue:26.0/255.0 alpha:1.0].CGColor;
 
    btn.hidden = hide;
    
}

- (void)viewWillAppear:(BOOL)animated{
 
    [self.navigationController setNavigationBarHidden:YES];

}

- (IBAction)historAction:(id)sender {
    
    _historBTN.hidden = YES;
    _logoImageView.hidden = NO;
    _historyDocBTN.hidden = NO;
    _fourmulaBTN.hidden = NO;
   
}

- (IBAction)historyDoctumentAction:(id)sender {
    HistoryDocumentController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryDocumentController"];
    view.navigationTitle = _historyDocBTN.titleLabel.text;
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)formulaAction:(id)sender {
    
    ArticleController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleController"];
    view.amandString = _fourmulaBTN.titleLabel.text;
    [self.navigationController pushViewController:view animated:YES];
}

@end
