//
//  CustumClass.m
//  Mego Shop Demo
//
//  Created by jaiom on 26/02/16.
//  Copyright (c) 2016 unity. All rights reserved.
//

#import "CustumClass.h"

NSArray *array;

@implementation CustumClass

-(void)viewDidLoad{
    
    array=[[NSArray alloc] initWithObjects:@"Feature1",@"Feature2", nil];
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UIButton *btn;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        btn=[[UIButton alloc] initWithFrame:CGRectMake(250,10, 40, 20)];
        btn.tag=111;
        [btn setTitle:@"Buy" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    cell.textLabel.text=[array objectAtIndex:indexPath.row];
    [btn viewWithTag:111];
    [btn addTarget:self action:@selector(tblButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    return cell;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
}

-(void)tblButtonClick:(UIButton*)sender{
    
    NSLog(@"tblButtonClick");
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:sender.titleLabel.text message:@"" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Cancel", nil];
    [alertView show];
}

@end
