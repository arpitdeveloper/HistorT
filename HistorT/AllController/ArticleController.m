//
//  ArticleController.m
//  HistorT
//
//  Created by Macbook Pro on 01/01/19.
//  Copyright © 2019 com. HistorT. All rights reserved.
//

#import "ArticleController.h"
#import "AllViewCell.h"
#import "SectionController.h"
#import "DetailsController.h"

#import <Firebase/Firebase.h>

@interface ArticleController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger length;
    NSDictionary *constDict;
    NSDictionary *const0Dict;
    NSDictionary *const1Dict;
    NSDictionary *formulasDict;
}
@property (strong, nonatomic) IBOutlet UINavigationItem *articleNavigation;
@property (strong, nonatomic) IBOutlet UITableView *articleTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableHightConstraint;
@property (strong, nonatomic) IBOutlet UIScrollView *articleSrollView;
@property (strong, nonatomic) IBOutlet UIView *articleView;
@property (strong, nonatomic) IBOutlet UILabel *articleTitleLB;

@end

@implementation ArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib * cellNib = [UINib nibWithNibName:@"AllViewCell" bundle:nil];
    [_articleTableView registerNib:cellNib forCellReuseIdentifier:@"AllViewCell"];
    
    //Design Part ----------------------------------------------------------
    _articleTitleLB.text = _amandString;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    [self.articleTableView setBackgroundView:nil];
    [self.articleTableView setBounces:NO];
    [self.articleTableView setBackgroundColor:[UIColor clearColor]];
    [self.articleSrollView setBackgroundColor:[UIColor clearColor]];
    [self.articleView setBackgroundColor:[UIColor clearColor]];
    
    //Firbase database------------------------------------------------------
    
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://histort-12563.firebaseio.com/data /"];
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *tempDict = snapshot.value;
        NSDictionary *conDict = [tempDict objectForKey:@"usconstitution"];
        NSDictionary *documentDict = [conDict objectForKey:@"document"];
        NSDictionary *formulaDict = [tempDict objectForKey:@"formulas"];
        
        self->formulasDict = [formulaDict objectForKey:@"data"];
        self->constDict = [documentDict objectForKey:@"constitution"];
        self->const0Dict = [documentDict objectForKey:@"constitution0"];
        self->const1Dict = [documentDict objectForKey:@"constitution1"];
        if ([self->_amandString isEqualToString: [self->constDict valueForKey:@"label"]]) {
            self->length = [self->constDict count];
        }
        if ([self->_amandString isEqualToString: [self->const0Dict valueForKey:@"label"]]){
            
            self->length = [self->const0Dict count];
        }
        if ([self->_amandString isEqualToString: [self->const1Dict valueForKey:@"label"]]){
            
            self->length = [self->const1Dict count];
        }
        if ([self->_amandString isEqualToString: [self->formulasDict valueForKey:@"label"]]){
            
            self->length = [self->formulasDict count];
           
        }
       
        [self.articleTableView reloadData];
        
        [self abc];
    } withCancelBlock:^(NSError *error) {
        
        NSLog(@"\n\n...That is Errrrror...\n%@\n", error.description);
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    //[self performSelector:@selector(abc) withObject:nil afterDelay:0.2];
    
}
-(void)abc{
    
    CGFloat tableheight = 0;
    
    for (int i = 0; i < self->length; i++) {
        
        NSIndexPath *indp = [NSIndexPath indexPathForRow:i inSection:0];
        CGRect frame = [self.articleTableView rectForRowAtIndexPath:indp];
        tableheight = tableheight + frame.size.height;
        //NSLog(@"cell %d row height : %f",i, frame.size.height);

    }
    
    [self.articleTableView setFrame:CGRectMake(self.articleTableView.frame.origin.x, self.articleTableView.frame.origin.y, self.view.frame.size.width, tableheight)];
    self.tableHightConstraint.constant = tableheight;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AllViewCell *cell = (AllViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AllViewCell" forIndexPath:indexPath];

    if(cell == nil)
    {
        
        cell = [[AllViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllViewCell"];
        
    }
    
     if ([self->_amandString isEqualToString: [self->constDict valueForKey:@"label"]]) {
         NSString *articlString = [NSString stringWithFormat:@"article%ld",(long)indexPath.row];
         
         NSDictionary *articleDict = [constDict objectForKey:articlString];
         NSDictionary *seDict = [articleDict objectForKey:@"section"];
         NSInteger num = [seDict count];
         NSString *countNum = [NSString stringWithFormat:@"1-%ld", (long)num];
         if (num == 0) {
             cell.countLB.hidden = YES;
         }else{
             cell.countLB.hidden = NO;
             cell.countLB.text = countNum;
         }
         cell.numberLB.text = [articleDict valueForKey:@"number"];
         cell.articleNameLB.text = [articleDict valueForKey:@"title"];

         cell.titleLabel.text = @"ANNOTATIONS";
     }
    if ([self->_amandString isEqualToString: [self->const0Dict valueForKey:@"label"]]){
        
        NSString *amendmentString = [NSString stringWithFormat:@"amendment%ld",(long)indexPath.row];
        
        NSDictionary *articleDict = [const0Dict objectForKey:amendmentString];
        NSDictionary *seDict = [articleDict objectForKey:@"section"];
        NSInteger num = [seDict count];
        NSString *countNum = [NSString stringWithFormat:@"1-%ld", (long)num];
        if (num == 0) {
            cell.countLB.hidden = YES;
        }else{
            cell.countLB.hidden = NO;
            cell.countLB.text = countNum;
        }
        cell.numberLB.text = [articleDict valueForKey:@"number"];
        cell.articleNameLB.text = [articleDict valueForKey:@"title"];
        cell.titleLabel.text = @"ANNOTATIONS";
    }
    if ([self->_amandString isEqualToString: [self->const1Dict valueForKey:@"label"]]){
        
        NSString *amendmentString = [NSString stringWithFormat:@"amendment%ld",(long)indexPath.row];
        
        NSDictionary *articleDict = [const1Dict objectForKey:amendmentString];
        NSDictionary *seDict = [articleDict objectForKey:@"section"];
        NSInteger num = [seDict count];
        NSString *countNum = [NSString stringWithFormat:@"1-%ld", (long)num];
        if (num == 0) {
            cell.countLB.hidden = YES;
        }else{
            cell.countLB.hidden = NO;
            cell.countLB.text = countNum;
        }
        cell.numberLB.text = [articleDict valueForKey:@"number"];
        cell.articleNameLB.text = [articleDict valueForKey:@"title"];
        cell.titleLabel.text = @"ANNOTATIONS";
    }
    if ([self->_amandString isEqualToString:[self->formulasDict valueForKey:@"label"]]){
        NSString *amendmentString = [NSString stringWithFormat:@"data%ld",(long)indexPath.row];
        
        NSDictionary *articleDict = [formulasDict objectForKey:amendmentString];
        NSDictionary *seDict = [articleDict objectForKey:@"section"];
        NSInteger num = [seDict count];
        NSString *countNum = [NSString stringWithFormat:@"1-%ld", (long)num];
        if (num == 0) {
            cell.countLB.hidden = YES;
        }else{
            cell.countLB.hidden = NO;
            cell.countLB.text = countNum;
        }
        cell.numberLB.text = [[articleDict valueForKey:@"number"] stringValue];
        cell.articleNameLB.text = [articleDict valueForKey:@"title"];
        cell.titleLabel.text = [articleDict valueForKey:@"label"];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self->length-1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self->_amandString isEqualToString: [self->constDict valueForKey:@"label"]]){
        
        NSString *articlString = [NSString stringWithFormat:@"article%ld",(long)indexPath.row];
        NSDictionary *articleDict = [constDict objectForKey:articlString];
        NSDictionary *secteDict = [articleDict objectForKey:@"section"];
        
        if (secteDict == nil) {
            
            DetailsController *viewNEXT= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
            viewNEXT.articleLabel = articlString;
            [self.navigationController pushViewController:viewNEXT animated:YES];
            
        }
        else{
            SectionController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SectionController"];
            view.selectArticleData = articlString;

            [self.navigationController pushViewController:view animated:YES];
        }
    }
    if ([self->_amandString isEqualToString: [self->const0Dict valueForKey:@"label"]]){
        NSString *amendmentString = [NSString stringWithFormat:@"amendment%ld",(long)indexPath.row];
        
        NSDictionary *articleDict = [const0Dict objectForKey:amendmentString];
        NSDictionary *sectDict = [articleDict objectForKey:@"section"];
        if (sectDict == nil) {
            
            DetailsController *viewNEXT= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
            viewNEXT.amedData = amendmentString;
            [self.navigationController pushViewController:viewNEXT animated:YES];
            
        }
        else{
            
            SectionController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SectionController"];
            view.selectAmendData = amendmentString;
            [self.navigationController pushViewController:view animated:YES];
            
        }
    }
    if ([self->_amandString isEqualToString: [self->const1Dict valueForKey:@"label"]]){
        NSString *amendmentString = [NSString stringWithFormat:@"amendment%ld",(long)indexPath.row];
        
        NSDictionary *articleDict = [const1Dict objectForKey:amendmentString];
        NSDictionary *sectDict = [articleDict objectForKey:@"section"];
        if (sectDict == nil) {
            
            DetailsController *viewNEXT= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
            viewNEXT.amed2Data = amendmentString;
            [self.navigationController pushViewController:viewNEXT animated:YES];
            
        }
        else{
            
            SectionController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SectionController"];
            view.selectAmend2Data = amendmentString;
            [self.navigationController pushViewController:view animated:YES];
        }
    }
    if ([self->_amandString isEqualToString: [self->formulasDict valueForKey:@"label"]]){
        
        NSString *amendmentString = [NSString stringWithFormat:@"data%ld",(long)indexPath.row];
        DetailsController *viewNEXT= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsController"];
        viewNEXT.formulaData = amendmentString;
        [self.navigationController pushViewController:viewNEXT animated:YES];

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

@end
