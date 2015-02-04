//
//  ViewController.m
//  Score Keeper
//
//  Created by David Monson on 2/3/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()  <UITextFieldDelegate>

@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat navHeight;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *scoreLabels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navHeight = 64;
    self.screenWidth = self.view.frame.size.width;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.screenWidth, self.view.frame.size.height - self.navHeight)];
    [self.view addSubview:self.scrollView];
    [self setTitle:@"Score Keeper"];
    self.scoreLabels = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < 4; i++) {
        [self addScoreView:i];
    }
}

- (void)addScoreView:(int)index {
    CGFloat viewHeight = 70;
    
    UIView *longView = [[UIView alloc] initWithFrame:CGRectMake(0, index * viewHeight, self.screenWidth, viewHeight)];
    
#pragma mark - UITextField
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(20, viewHeight / 2 - 10, 50, 20)];
    [name setPlaceholder:@"Name"];
    [name setDelegate:self];

#pragma mark - UILabel
    
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 20, viewHeight / 2 - 10 , 40 , 20)];
    [score setText:@"0"];
    [score setTextAlignment:NSTextAlignmentCenter];
    [score setTag:index];
    [self.scoreLabels addObject:score];
    
#pragma mark - UIStepper
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(self.screenWidth - 100,  viewHeight / 2 - 15 , 50 , 20)];
    [stepper setMinimumValue:-1000];
    [stepper setMaximumValue:1000];
    [stepper setTag:index];
    [stepper addTarget:self action:@selector(changeScore:) forControlEvents:UIControlEventValueChanged];
    

#pragma mark - Bottom Line
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.navHeight + (index * viewHeight) + 4, self.screenWidth, 2)];
    [line setBackgroundColor:[UIColor blackColor]];
    
    
#pragma mark - Adding Subviews
    
    [self.scrollView addSubview:longView];
    [longView addSubview:name];
    [longView addSubview:score];
    [longView addSubview:stepper];
    [self.scrollView addSubview:line];
    
}

- (void)changeScore:(id)sender {
    UIStepper *stepper2 = sender;
    double scoreValue = [stepper2 value];
    NSInteger index = stepper2.tag;
    UILabel *scorePrint = [self.scoreLabels objectAtIndex:index];
    [scorePrint setText:[NSString stringWithFormat:@"%0.0f", scoreValue]];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
