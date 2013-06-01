//
//  SCLoginViewController.m
//  FBApi
//
//  Created by Nisha Shah on 5/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "SCLoginViewController.h"
#import "FrontViewControllerAppDelegate.h"


@interface SCLoginViewController ()
- (IBAction)performLogin:(id)sender;
//@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation SCLoginViewController
@synthesize mealImageView;
@synthesize mealTextView;
//@synthesize btnLogin;
@synthesize lblMealName;


@synthesize spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/*
 Obtain the selected meal from the app delegate variable and display title , image and description.
 Variables of app delegate are like global variables. They can be accessed throughout the application.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FrontViewControllerAppDelegate *appDelegate = (FrontViewControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"APP DELEGATE VARIABLE %@",appDelegate.selectedItemMain);
    
    lblMealName.text=appDelegate.selectedItemMain;
    lblMealName.textColor=[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(205.0/255.0) alpha:1];
    
    
    mealTextView.text=appDelegate.selectedItemMain;
    
    // UI decoration
    [mealTextView setFont:[UIFont fontWithName:@"Arial" size:15 ]];
    [mealTextView setTextColor:[UIColor blackColor]/*[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(205.0/255.0) alpha:1]*/];
    
    if([appDelegate.selectedItemMain isEqualToString:@"Brussels Sprouts"]){
    mealImageView.image=[UIImage imageNamed:@"brussels.jpg"];
        mealTextView.text=@"Organic brussels sprouts with olive oil aioli and espelette pepper";
    }else if([appDelegate.selectedItemMain isEqualToString:@"Banana Cake"]){
    mealImageView.image=[UIImage imageNamed:@"bananaCake.jpg"];
        mealTextView.text=@"Cake with whipped vanilla cream and caramel sauce";
    }else{
      mealImageView.image=[UIImage imageNamed:@"burger.jpg"];
        mealTextView.text=@"Cheese burger with pork bacon, cave-aged gruyere, and organic mixed greens on a sesame seed bun.";
    }

    
    /*
     UI decoration
     */
    
   // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:0.5];
    self.navigationItem.title = @"Login";
  
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"civerPage3.jpg"]];
    
        
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(performLogin:)];
    [anotherButton setImage:[UIImage imageNamed:@"gearIcon1.png"]];
    [anotherButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=anotherButton;
    
   // btnLogin.hidden=YES;
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)performLogin:(id)sender {
    NSLog(@"Login button clicked");
    [self.spinner startAnimating];
    
    [self.navigationController pushViewController:[[FBUserSettingsViewController alloc] init]
                                         animated:YES];
    
    /*
    FrontViewControllerAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession]; 
     */
}

- (IBAction)btnShareClick:(id)sender {
    //new added
    
    id<SCOGEatMealAction> action = (id<SCOGEatMealAction>)[FBGraphObject graphObject];
    
    if([self.lblMealName.text isEqualToString:@"Brussels Sprouts"])
        action[@"meal"] =@"114527235420691"; //BRUSSELS
    else if([self.lblMealName.text isEqualToString:@"Banana Cake"]){
        action[@"meal"] =@"450030578415741"; //CAke
    }else{
        action[@"meal"] =@"166807836819222"; //Burger
    }
    
    
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"meals-nisha:eat"
                                 previewPropertyName:@"meal"
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if(error) {
                                                     NSLog(@"Error: %@", error.description);
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Error"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK!"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 } else {
                                                     NSLog(@"Success!");
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Posted Open Graph action successfully"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK !"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 }
                                             }];
    
    
    

}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}


-(void)btnShareClicked {
    id<SCOGEatMealAction> action = (id<SCOGEatMealAction>)[FBGraphObject graphObject];
    
    if([self.lblMealName.text isEqualToString:@"Brussels Sprouts"])
        action[@"meal"] =@"114527235420691"; //BRUSSELS
    else if([self.lblMealName.text isEqualToString:@"Banana Cake"]){
        action[@"meal"] =@"450030578415741"; //CAke
    }else{
        action[@"meal"] =@"166807836819222"; //Burger
    }
    
    
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"meals-nisha:eat"
                                 previewPropertyName:@"meal"
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if(error) {
                                                     NSLog(@"Error: %@", error.description);
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Error"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK!"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 } else {
                                                     NSLog(@"Success!");
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Posted Open Graph action successfully"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK !"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 }
                                             }];
    
    


}
@end
