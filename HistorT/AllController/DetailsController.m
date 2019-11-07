//
//  DetailsController.m
//  HistorT
//
//  Created by Macbook Pro on 28/12/18.
//  Copyright © 2018 com. HistorT. All rights reserved.
//

#import "DetailsController.h"
#import "TextPageController.h"

#import <Firebase/Firebase.h>

@interface DetailsController ()
{
    NSMutableDictionary *_infoDataDict;
    BOOL isButtonT;
}
@property (strong, nonatomic) IBOutlet UIView *view1;

@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@property (strong, nonatomic) IBOutlet UIButton *backBTN;
@property (strong, nonatomic) IBOutlet UIButton *btnView1;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightLayoutview;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLayoutView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoTopLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logowitdthlayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TextViewRightLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnWidthLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWitdthlayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textViewWitdthllayout;

@property (strong, nonatomic) IBOutlet UIView *inSideView;

@end

@implementation DetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

 //Design Start (ViewDidLoad)----------------------------------------------
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];

    _detailTextView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self viewEdit:_view1];
    _backBTN.hidden = YES;

    [self.btnView1 setTitle:_labelData forState:UIControlStateNormal];
    
 //Design End (ViewDidLoad)------------------------------------------------
    
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://histort-12563.firebaseio.com/"];
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *tempDict = snapshot.value;
        
        NSDictionary *bookDict = [tempDict objectForKey:@"data "];
        NSDictionary *usDict = [bookDict objectForKey:@"usconstitution"];
        NSDictionary *docDict =[usDict objectForKey:@"document"];

        self->_infoDataDict = [[NSMutableDictionary alloc]init];
        
        if (self.articleLabel != nil) {
            
            NSDictionary *constiDict =[docDict objectForKey:@"constitution"];
            NSDictionary *artDict =[constiDict objectForKey:self.articleLabel];
            NSDictionary *othDict =[artDict objectForKey:@"section"];
            NSDictionary *sectionDict =[othDict objectForKey:self.sectionLabel];
            if (sectionDict == nil) {
                NSString *num = [artDict valueForKey:@"number"];
                [self.btnView1 setTitle:[NSString stringWithFormat:@"ARTICLE %@",num] forState:UIControlStateNormal];
                self.detailTextView.text = [artDict valueForKey:@"data"];
            }
            else{
                NSString *num = [[sectionDict valueForKey:@"number"] stringValue];
                [self.btnView1 setTitle:[NSString stringWithFormat:@"SECTION %@",num] forState:UIControlStateNormal];
                self.detailTextView.text = [sectionDict valueForKey:@"data"];
            }
        }
        if (self.amedData != nil) {
            
            NSDictionary *constiDict =[docDict objectForKey:@"constitution0"];
            NSDictionary *artDict =[constiDict objectForKey:self.amedData];
            NSDictionary *othDict =[artDict objectForKey:@"section"];
            NSDictionary *sectionDict =[othDict objectForKey:self.sectionLabel];
            
            if (sectionDict == nil) {
                self.detailTextView.text = [artDict valueForKey:@"data"];
                NSString *num = [artDict valueForKey:@"number"];
                
                [self.btnView1 setTitle:[NSString stringWithFormat:@"AMENDMENT %@",num] forState:UIControlStateNormal];
            }else{
                NSString *num = [[sectionDict valueForKey:@"number"] stringValue];
                [self.btnView1 setTitle:[NSString stringWithFormat:@"SECTION %@",num] forState:UIControlStateNormal];
                self.detailTextView.text = [sectionDict valueForKey:@"data"];
            }
        }
        if (self.amed2Data != nil) {
            
            NSDictionary *constiDict =[docDict objectForKey:@"constitution1"];
            NSDictionary *artDict =[constiDict objectForKey:self.amed2Data];
            NSDictionary *othDict =[artDict objectForKey:@"section"];
            NSDictionary *sectionDict =[othDict objectForKey:self.sectionLabel];
            if (sectionDict == nil) {
                self.detailTextView.text = [artDict valueForKey:@"data"];
                NSString *num = [artDict valueForKey:@"number"];
                
                [self.btnView1 setTitle:[NSString stringWithFormat:@"AMENDMENT %@",num] forState:UIControlStateNormal];
            }else{
                NSString *num = [[sectionDict valueForKey:@"number"] stringValue];
                [self.btnView1 setTitle:[NSString stringWithFormat:@"SECTION %@",num] forState:UIControlStateNormal];
                self.detailTextView.text = [sectionDict valueForKey:@"data"];
            }
        }
      if (self.labelData != nil) {
          
          NSDictionary *decDict = [bookDict objectForKey:@"declaration"];
          [self.btnView1 setTitle:[decDict valueForKey:@"label"] forState:UIControlStateNormal];
          self.detailTextView.text = [decDict valueForKey:@"data"];
          
        }
      if (self.formulaData != nil){
          NSDictionary *formulaDict  = [bookDict objectForKey:@"formulas"];
          NSDictionary *dtDict = [formulaDict objectForKey:@"data"];
          NSDictionary *dt0Dict = [dtDict objectForKey:self.formulaData];
          [self.btnView1 setTitle:[dt0Dict valueForKey:@"label"] forState:UIControlStateNormal];
          NSString *dataStr = [dt0Dict valueForKey:@"data"];
          self.detailTextView.text = dataStr;
          
      }
        self->_infoDataDict = [bookDict objectForKey:@"information"];

    } withCancelBlock:^(NSError *error) {
        
        NSLog(@"%@", error.description);
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    [self.detailTextView setContentOffset:CGPointZero animated:NO];
  
}

#pragma mark - View Edit

-(void)viewEdit:(UIView *)obj{
    
    [obj.layer setCornerRadius:20.0f];
    [obj.layer setBorderColor:[UIColor colorWithRed:127.0/255.0 green:86.0/255.0 blue:26.0/255.0 alpha:1.0].CGColor];
    [obj.layer setBorderWidth:0.2f];
    [obj.layer setShadowColor:[UIColor colorWithRed:127.0/255.0 green:86.0/255.0 blue:26.0/255.0 alpha:1.0].CGColor];
    [obj.layer setShadowOpacity:1.0];
    [obj.layer setShadowRadius:6.0];
    [obj.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
    obj.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];

}

- (void)setView:(UIView*)view hidden:(BOOL)hidden {
    [UIView transitionWithView:view duration:0.9 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [view setHidden:hidden];
    } completion:nil];
}

#pragma mark - Button Action

- (IBAction)viewBackAction:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)firstActionBTN:(id)sender {
    
    if (isButtonT != YES) {
        
        [UIView animateWithDuration:0.5 delay:0.0 options: UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.view1.frame = CGRectMake(0, 25, self.view.bounds.size.width, self.view.bounds.size.height);
            self.detailTextView.frame = CGRectMake(35, 35, self.view1.bounds.size.width-60, self.view1.bounds.size.height);
            self.btnView1.frame = CGRectMake(-10, 0, self.view.bounds.size.width, 20);
            
            self.leftLayoutView.constant = 0;
            self.bottomLayoutView.constant = 0;
            self.rightLayoutview.constant = 0;
            self.logoTopLayout.constant = 0;
            self.logowitdthlayout.constant = 0;
            self.TextViewRightLayout.constant = 0;
            self.TextViewRightLayout.constant = 0;
            self.viewWitdthlayout.constant = 0;
            self.topLayoutView.constant = 0;
            
            self.view1.layer.cornerRadius = 0;
            self.view1.layer.shadowRadius = 0;
            self.view1.layer.borderWidth = 0;
            [self.view1.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];

            self.inSideView.hidden = YES;
        }
    completion:^(BOOL finished){
        
            self.backBTN.hidden = NO;
            self.view1.alpha = 1.0;
            [self.detailTextView setContentOffset:CGPointZero animated:NO];
                             
        }];
     
        [self.view addSubview:self.view1];
        isButtonT = YES;
    }
}


@end
