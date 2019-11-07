//
//  ConstitutinoController.m
//  HistorT
//
//  Created by Macbook Pro on 02/01/19.
//  Copyright © 2019 com. HistorT. All rights reserved.
//

#import "ConstitutinoController.h"
#import "ArticleController.h"
#import <Firebase/Firebase.h>

@interface ConstitutinoController ()
{
    NSDictionary *documentDict;
}
@property (strong, nonatomic) IBOutlet UINavigationItem *usNavigation;

@property (strong, nonatomic) IBOutlet UILabel *titleLB;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewAD;
@property (strong, nonatomic) IBOutlet UIView *viewAD;

@property (strong, nonatomic) IBOutlet UIButton *articleBTN;
@property (strong, nonatomic) IBOutlet UIButton *amendBTN;
@property (strong, nonatomic) IBOutlet UIButton *amend2BTN;

@end

@implementation ConstitutinoController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    [self.scrollViewAD setBackgroundColor:[UIColor clearColor]];
    [self.viewAD setBackgroundColor:[UIColor clearColor]];
    [self btnEditAction:_articleBTN];
    [self btnEditAction:_amendBTN];
    [self btnEditAction:_amend2BTN];
    _usNavigation.title = _navigationTitle;

//Firbase ----------------------------------------------

    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://histort-12563.firebaseio.com/data /usconstitution/"];
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSDictionary *tempDict = snapshot.value;
        self->documentDict = [tempDict objectForKey:@"document"];
        
        NSDictionary *const0Dict = [self->documentDict objectForKey:@"constitution"];
        [self.articleBTN setTitle:[const0Dict valueForKey:@"label"] forState:UIControlStateNormal];
        
        NSDictionary *const1Dict = [self->documentDict objectForKey:@"constitution0"];
        [self.amendBTN setTitle:[const1Dict valueForKey:@"label"] forState:UIControlStateNormal];
        
        NSDictionary *const2Dict = [self->documentDict objectForKey:@"constitution1"];
        [self.amend2BTN setTitle:[const2Dict valueForKey:@"label"] forState:UIControlStateNormal];
        
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

- (IBAction)articleAction:(id)sender {
    
    ArticleController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleController"];
    NSDictionary *articDict = [documentDict objectForKey:@"constitution"];
    view.amandString = [articDict valueForKey:@"label"];
    
    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)amendAction:(id)sender {
    
    ArticleController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleController"];
    NSDictionary *amandDict = [documentDict objectForKey:@"constitution0"];
    view.amandString = [amandDict valueForKey:@"label"];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)amend2Action:(id)sender {
    
    ArticleController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleController"];
    NSDictionary *amandDict = [documentDict objectForKey:@"constitution1"];
    view.amandString = [amandDict valueForKey:@"label"];
    [self.navigationController pushViewController:view animated:YES];
}

@end
