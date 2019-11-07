//
//  SectionController.m
//  HistorT
//
//  Created by Macbook Pro on 01/01/19.
//  Copyright © 2019 com. HistorT. All rights reserved.
//

#import "SectionController.h"
#import "AllViewCell.h"
#import "DetailsController.h"
#import <Firebase/Firebase.h>
@interface SectionController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger secCount;
    NSDictionary *sectionDict;
}
@property (strong, nonatomic) IBOutlet UINavigationItem *sectionNavigation;

@property (strong, nonatomic) IBOutlet UITableView *sectionTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sectionTableHeightConstant;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionSrollView;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (strong, nonatomic) IBOutlet UILabel *articleNameLB;
@property (strong, nonatomic) IBOutlet UILabel *articleTitleLB;

@end

@implementation SectionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UINib * cellNib = [UINib nibWithNibName:@"AllViewCell" bundle:nil];
    [_sectionTableView registerNib:cellNib forCellReuseIdentifier:@"AllViewCell"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    [self.sectionTableView setBackgroundView:nil];
    [self.sectionTableView setBackgroundColor:[UIColor clearColor]];
    [self.sectionSrollView setBackgroundColor:[UIColor clearColor]];
    [self.sectionView setBackgroundColor:[UIColor clearColor]];
    [self.sectionTableView setBounces:NO];
    
    //Firebase ----------------------------------------------------
    
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://histort-12563.firebaseio.com/data /usconstitution/document"];
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *tempDict = snapshot.value;
        
        if (self.selectArticleData != nil) {
            
            NSDictionary *constitutionDict = [tempDict objectForKey:@"constitution"];
            NSDictionary *artDict = [constitutionDict objectForKey:self.selectArticleData];
           
            self->sectionDict = [artDict objectForKey:@"section"];
            self->secCount = self->sectionDict.count;
            
            NSArray *sectionArray = [[NSArray alloc]initWithObjects:@"ARTICLE", [artDict valueForKey:@"number"], nil];
            
            NSString *lbString = [sectionArray componentsJoinedByString:@" "];
            self.articleNameLB.text = lbString;
            [self.sectionTableView reloadData];
        }
        if (self.selectAmendData != nil) {
            NSDictionary *constitutionDict = [tempDict objectForKey:@"constitution0"];
            NSDictionary *artDict = [constitutionDict objectForKey:self.selectAmendData];
            
            self->sectionDict = [artDict objectForKey:@"section"];
            self->secCount = self->sectionDict.count;
            
            NSArray *sectionArray = [[NSArray alloc]initWithObjects:@"AMENDMENT", [artDict valueForKey:@"number"], nil];
            
            NSString *lbString = [sectionArray componentsJoinedByString:@" "];
            self.articleNameLB.text = lbString;
            [self.sectionTableView reloadData];
        }
        if (self.selectAmend2Data != nil) {
            
            NSDictionary *constitutionDict = [tempDict objectForKey:@"constitution1"];
            NSDictionary *artDict = [constitutionDict objectForKey:self.selectAmend2Data];
            
            self->sectionDict = [artDict objectForKey:@"section"];
            self->secCount = self->sectionDict.count;
            
            NSArray *sectionArray = [[NSArray alloc]initWithObjects:@"AMENDMENT", [artDict valueForKey:@"number"], nil];
            
            NSString *lbString = [sectionArray componentsJoinedByString:@" "];
            self.articleNameLB.text = lbString;
            [self.sectionTableView reloadData];
        }
 
    } withCancelBlock:^(NSError *error) {
        
        NSLog(@"\n\n...That is Errrrror...\n%@\n", error.description);
        
    }];
  
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    [self performSelector:@selector(abc) withObject:nil afterDelay:0.2];
}

-(void)abc{
    
    CGFloat tableheight = 0;
  
    for (int i = 0; i < self->secCount; i++) {
        NSIndexPath *indp = [NSIndexPath indexPathForRow:i inSection:0];
        CGRect frame = [self.sectionTableView rectForRowAtIndexPath:indp];
        tableheight = tableheight + frame.size.height;
  
    }
    
    [self.sectionTableView setFrame:CGRectMake(self.sectionTableView.frame.origin.x, self.sectionTableView.frame.origin.y, self.view.frame.size.width, tableheight)];
    
    self.sectionTableHeightConstant.constant = tableheight;
}

#pragma mark - Table View



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AllViewCell *cell = (AllViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AllViewCell" forIndexPath:indexPath];

    if(cell == nil)
    {
        cell = [[AllViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllViewCell"];
    }
    
    NSString *articlString = [NSString stringWithFormat:@"section%ld",(long)indexPath.row];
    NSDictionary *articleDict = [sectionDict objectForKey:articlString];
    
    cell.numberLB.text = [[articleDict valueForKey:@"number"] stringValue];
    cell.articleNameLB.text = @"SECTION";
    cell.titleLabel.text = @"SECTION TITLE";
    cell.countLB.hidden = YES;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return secCount;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
 
    view.sectionLabel = [NSString stringWithFormat:@"section%ld",(long)indexPath.row];
    if (self.selectAmendData != nil){
        view.amedData = _selectAmendData;
    }
    if (self.selectAmend2Data != nil){
        view.amed2Data = _selectAmend2Data;
    }
    if (self.selectArticleData != nil)  {
        view.articleLabel = _selectArticleData;
    }
    
    [self.navigationController pushViewController:view animated:YES];
    
}
@end
