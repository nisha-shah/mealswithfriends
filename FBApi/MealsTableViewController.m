//
//  MealsTableViewController.m
//  FBApi
//
//  Created by Nisha Shah on 5/16/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "MealsTableViewController.h"
#import "FrontViewControllerAppDelegate.h"



@implementation MealsTableViewController
@synthesize loginViewController;
@synthesize mealList;
@synthesize scViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
       
        
    }
    return self;
}


/*
 This is the first method called on page load.
 Load the array list with 3 meals to be displayed.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //  NSLog(@"in meal list");
    self.mealList=[[NSArray alloc]initWithObjects:@"Brussels Sprouts",@"Banana Cake",@"Cheese Burger",nil];
   // self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];
    
    /* UI Decoration*/
    [self.tableView setBackgroundColor:[UIColor clearColor]];
  //  [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    //converting an RGB Color
       UIColor *myColor3 = [UIColor colorWithRed:(200.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:0.5];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.title = @"Meals With Friends";
   // self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
    self.tableView.backgroundColor = [UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:0.5];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(performLogin:)];
    [anotherButton setImage:[UIImage imageNamed:@"gearIcon1.png"]];
    [anotherButton setTintColor:[UIColor whiteColor]];
      self.navigationItem.rightBarButtonItem=anotherButton;
   
}

-(void)performLogin:(id)sender{
    [self.navigationController pushViewController:[[FBUserSettingsViewController alloc]init] animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

/*
 Returns the number of sections in the table view.
 All the meals are displayed under 1 single section . Thus return 1.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


/*
 Display eact meal on 1 row from the array list.
 Total number of rows = total meals in the mealList.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 return self.mealList.count;
}


/*
 In Objective C , cell = table row.
 Display,meal name, meal image and subtext in the row.
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        /*
         initialised with style= "UITableViewCellStyleSubtitle" to display sub text under the meal name.
         */
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
       
    }
    [cell sizeToFit];
    cell.textLabel.text=[self.mealList objectAtIndex:indexPath.row];
    cell.textLabel.hidden=YES;
    
    UILabel * imgLable = [[UILabel alloc]init];
       
    [imgLable setFrame:CGRectMake(0.0, 60.0, 320.0, 270.0)]; //final dimensions
   // imgLable.textAlignment=UIControlContentVerticalAlignmentTop;
    
    UILabel *mealNAmeLabel=[[UILabel alloc]init];
    [mealNAmeLabel setFrame:CGRectMake(20.0, 0.0, 280.0, 60.0)];
  //  [mealNAmeLabel setBackgroundColor:[UIColor redColor]];
    [mealNAmeLabel setNumberOfLines:0];
    
    
   [imgLable setNumberOfLines:0];
   // [imgLable alignmentRectForFrame:CGRectMake(10.0, 40.0, 250.0, 250.0)];

    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(3.0, 00.0, 320.0, 300.0)];
      
    if([cell.textLabel.text isEqualToString:@"Brussels Sprouts"]){
       mealNAmeLabel.text=[NSString stringWithFormat:@"Brussels \nOrganic brussels sprouts with espelette pepper"];
       // imgLable.text=[NSString stringWithFormat:@"Brussels \nOrganic brussels sprouts with espelette pepper"];
      //  imgLable.text=@"Brussels";
         [image setImage:[UIImage imageNamed:@"brussels.jpg"]];
       
    
    }else if ([cell.textLabel.text isEqualToString:@"Banana Cake"]){
        mealNAmeLabel.text=[NSString stringWithFormat:@"Banana Cake \nCake with whipped vanilla cream and caramel sauce"];
        imgLable.text=@"Banana Cake";
         [image setImage:[UIImage imageNamed:@"bananaCake.jpg"]];

    }else{
      //  mealNAmeLabel.text=@"Cheese Burger";
        mealNAmeLabel.text=[NSString stringWithFormat:@"Cheese Burger \n Beef burger with organic mixed greens on a sesame seed bun."];
        
        imgLable.text=@"Cheese Burger";
         [image setImage:[UIImage imageNamed:@"burger.jpg"]];

    }
    
    
   [imgLable addSubview:image];
   
        
   // [imgLable sizeToFit];
    
    
   [cell addSubview:mealNAmeLabel];
 //
    //[imgLable sizeThatFits:CGSizeMake(280.0,320.0)];
   [cell addSubview:imgLable];
    
    
/*
    UIButton *button1=[[UIButton alloc]init];
    [button1 setFrame:CGRectMake(30.0, 10.0, 250.0, 250.0)];
   button1.imageView.image=[UIImage imageNamed:@"bananaCake.jpg"];

       button1.titleLabel.text=@"BANANA CAKE";
    

    [cell addSubview:button1];
    
    */
    
    
    // Configure the cell .
    //  NSLog(@"Cell data is %@",[self.mealList objectAtIndex:indexPath.row]);
  /*  cell.textLabel.text=[self.mealList objectAtIndex:indexPath.row];
    
    if([cell.textLabel.text isEqualToString:@"Brussels"]){
       // cell.imageView.image = [UIImage imageNamed:@"brussels.jpg"];
        cell.detailTextLabel.text=@"Organic brussels sprouts with espelette pepper";
         cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brussels.jpg" ]];
    }
    else if([cell.textLabel.text isEqualToString:@"Banana Cake"]){
        //cell.imageView.image = [UIImage imageNamed:@"bananaCake.jpg"];
        cell.detailTextLabel.text=@"Cake with caramel sauce";
        
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bananaCake.jpg" ]];


    }
    else{
       // cell.imageView.image = [UIImage imageNamed:@"burger.jpg"];
        cell.detailTextLabel.text=@"Beef burger on a sesame seed bun.";
                
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"burger.jpg" ]];

    }*/
    
    /*
     Displaying the arrow on the row. Action = "on click of arrow",corresponding row gets selected.
     */
   // - -  cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    
   
    
    return cell;

}



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    //  NSLog(@"in acccessory tap buton");
    
    loginViewController=[[SCLoginViewController alloc]initWithNibName:@"SCLoginViewController" bundle:nil];
    
    FrontViewControllerAppDelegate *appDelegate = (FrontViewControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.selectedItemMain=[mealList objectAtIndex:indexPath.row];
    
    
    //  NSString *temp=[mealList objectAtIndex:indexPath.row];
  /*  dvc.selItem=[mealList objectAtIndex:indexPath.row];*/
    
    //  dvc.lblMealName.text=[mealList objectAtIndex:indexPath.row];
    //  NSLog(@"VC LABEL TEXT IS %@",dvc.selItem);
    
    
    
   /* [self.navigationController pushViewController:dvc animated:YES];*/
    
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row clicked : Selected row is %d",indexPath.row);
   /* scViewController=[[SCViewController alloc]initWithNibName:@"SCViewController" bundle:nil];
    
    FrontViewControllerAppDelegate *appDelegate = (FrontViewControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.selectedItemMain=[mealList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:scViewController animated:YES];
    
*/
    
    loginViewController=[[SCLoginViewController alloc]initWithNibName:@"SCLoginViewController" bundle:nil];
    
    FrontViewControllerAppDelegate *appDelegate = (FrontViewControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.selectedItemMain=[mealList objectAtIndex:indexPath.row];
       [self.navigationController pushViewController:loginViewController animated:YES];
    

    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
