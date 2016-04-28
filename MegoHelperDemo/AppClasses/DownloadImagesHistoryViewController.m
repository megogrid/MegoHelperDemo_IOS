//
//  DownloadImagesHistoryViewController.m
//  Mego Shop Demo
//
//  Created by ankit-iphone on 2/16/16.
//  Copyright (c) 2016 unity. All rights reserved.
//

#import "DownloadImagesHistoryViewController.h"

@interface DownloadImagesHistoryViewController ()
{
    UIView *mainView;
    NSMutableArray *ImageDescriptionArray;
    NSMutableArray *ImageNameArray;
    NSMutableArray *ImageDateArray;
    NSMutableArray *ImageTimeArray;
    
}

@end

@implementation DownloadImagesHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    mainView.backgroundColor=[UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1];
    [self.view addSubview:mainView];
    
    [self headerSection];
    [self loadTableView];
    
}

-(void)headerSection
{
    UIView*headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,64)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:79/255.0f green:109/255.0f blue:147/255.0f alpha:1]];
    [self.view addSubview:headerView];
    
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 19, self.view.frame.size.width,45)];
    [headerView addSubview:navView];
    
    UIButton *sliderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sliderButton setFrame:CGRectMake(15,12,20,21)];
    [sliderButton addTarget:self action:@selector(getSlider)forControlEvents:UIControlEventTouchUpInside];
    [sliderButton setBackgroundImage:[UIImage imageNamed:@"back_icn.png"] forState:UIControlStateNormal];
    [sliderButton setBackgroundImage:[UIImage imageNamed:@"back_icn.png"] forState:UIControlStateSelected];
    [navView addSubview :sliderButton];
    
    UILabel*groupLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0 ,navView.frame.size.width, 45) ];
    groupLabel.text = @"History";
    groupLabel.textAlignment=NSTextAlignmentCenter;
    groupLabel.textColor = [UIColor whiteColor];
    groupLabel.font = [UIFont boldSystemFontOfSize:17];
    [navView addSubview:groupLabel];
    
//    UIButton *rightMenu = [[UIButton alloc]initWithFrame:CGRectMake(navView.frame.size.width-20, 15, 4, 15)];
//    [rightMenu addTarget:self action:@selector(rightMenuClick)forControlEvents:UIControlEventTouchUpInside];
//    [rightMenu setBackgroundImage:[UIImage imageNamed:@"Right_menu.png"] forState:normal ];
//    [navView addSubview :rightMenu];
//    
//    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(navView.frame.size.width-60, 14.5, 16, 16)];
//    [searchButton addTarget:self action:@selector(searchButtonClick)forControlEvents:UIControlEventTouchUpInside];
//    [searchButton setBackgroundImage:[UIImage imageNamed:@"search_icn.png"] forState:normal ];
//    [navView addSubview :searchButton];
}

-(void)loadTableView
{
    
    ImageDescriptionArray=[[NSMutableArray alloc]init];
    ImageDateArray=[[NSMutableArray alloc]init];
    ImageTimeArray=[[NSMutableArray alloc]init];
    ImageNameArray=[[NSMutableArray alloc]init];
    
    [ImageDescriptionArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"meUserImageArray"]];
    
    if (ImageDescriptionArray.count==0)
    {
        UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                         message:@"No Records found!"
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UITableView *tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height) style:UITableViewStylePlain];
        
        [mainView addSubview:tableView1];
        tableView1.scrollEnabled = YES;
        tableView1.userInteractionEnabled = YES;
        tableView1.bounces = NO;
        tableView1.layer.borderWidth=1;
        tableView1.layer.borderColor=[UIColor grayColor].CGColor;
        
        tableView1.delegate = self;
        tableView1.dataSource = self;
        
        for (int i=0; i<ImageDescriptionArray.count; i++)
        {
            NSDictionary *imageData=[ImageDescriptionArray objectAtIndex:i];
            [ImageNameArray addObject:[imageData objectForKey:@"imageName"]];
            [ImageDateArray addObject:[imageData objectForKey:@"imageDate"]];
            [ImageTimeArray addObject:[imageData objectForKey:@"imageTime"]];
        }
    }
}

-(void)getSlider
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)searchButtonClick
{
    
}

-(void)rightMenuClick
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [ImageDescriptionArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell;
    
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    cell.separatorInset = UIEdgeInsetsMake(0,0,0,15);
    
    UIView *cellContentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, mainView.frame.size.width, 50)];
    [cell addSubview:cellContentView];
    
    UILabel *imageNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, cellContentView.frame.size.width, 20)];
    imageNameLabel.text=[ImageNameArray objectAtIndex:indexPath.row];
    imageNameLabel.textColor=[UIColor grayColor];
    imageNameLabel.font=[UIFont systemFontOfSize:15];
    [cellContentView addSubview:imageNameLabel];
    
    UILabel *imageDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 25, cellContentView.frame.size.width, 20)];
    imageDateLabel.text=[ImageDateArray objectAtIndex:indexPath.row];
    imageDateLabel.textColor=[UIColor grayColor];
    imageDateLabel.font=[UIFont systemFontOfSize:13];
    [cellContentView addSubview:imageDateLabel];
    
    UILabel *imageTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(cellContentView.frame.size.width-115, 25, 100, 20)];
    imageTimeLabel.text=[ImageTimeArray objectAtIndex:indexPath.row];
    imageTimeLabel.textColor=[UIColor grayColor];
    imageTimeLabel.font=[UIFont systemFontOfSize:13];
    imageTimeLabel.textAlignment=NSTextAlignmentRight;
    [cellContentView addSubview:imageTimeLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
