//
//  SlideView.m
//  Mego Shop Demo
//
//  Created by ankit-iphone on 2/12/16.
//  Copyright (c) 2016 unity. All rights reserved.
//

#import "SlideView.h"


@interface SlideView(){
  
    NSInteger tapCellIndex;
}



@end
@implementation SlideView
{
    UITableView *SlidetableView;
    UIView*sliderBG;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.totalItemArray = [NSArray arrayWithObjects:@"FAQ",@"Tutorial",@"FeedBack",@"Help",@"Rating",nil];
        self.imageArray=[NSArray arrayWithObjects:@"faq_app.png",@"tutorial_app.png",@"feedback_app.png",@"help_app.png",@"rating_app.png",nil];

        sliderBG=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                         64,
                                                         self.frame.size.width,
                                                         self.frame.size.height-64)];
        sliderBG.backgroundColor=[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:0.4];
        [self addSubview:sliderBG];
        SlidetableView=[[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    sliderBG.frame.size.width/1.35,
                                                                    sliderBG.frame.size.height)style:UITableViewStylePlain];
        
        
       
        
        
        SlidetableView.delegate=self;
        SlidetableView.dataSource=self;
        SlidetableView.userInteractionEnabled = YES;
        [SlidetableView setBackgroundColor: [UIColor colorWithRed:49/255.0f green:77/255.0f blue:114/255.0f alpha:1]];
        [SlidetableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [sliderBG addSubview:SlidetableView];
        SlidetableView.showsVerticalScrollIndicator=FALSE;
        
        
        tapCellIndex=-1;
        
        UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
        swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
        [sliderBG addGestureRecognizer:swipeleft];
        
       

    }
    return self;
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        sliderBG.frame=CGRectMake(-self.frame.size.width,
                                  64,
                                  self.frame.size.width,
                                  self.frame.size.height-
                                  64);
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        
    }];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.totalItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *cellContentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, sliderBG.frame.size.width/1.35, 50)];
    [cell addSubview:cellContentView];
    cellContentView.backgroundColor=[UIColor colorWithRed:49/255.0f green:77/255.0f blue:114/255.0f alpha:1];
    UIImageView *horzLine=[[UIImageView alloc]initWithFrame:CGRectMake(10, 48, cellContentView.frame.size.width-20, 2)];
    [cellContentView addSubview:horzLine];
    horzLine.backgroundColor=[UIColor colorWithRed:82/255.0f green:101/255.0f blue:130/255.0f alpha:1];
    ;
    UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(17, 17, 17, 15)];
    iconImage.image=[UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    [cellContentView addSubview:iconImage];
    
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, cellContentView.frame.size.width-50, 30)];
    titleLabel.text = [self.totalItemArray objectAtIndex:indexPath.row];
    [cellContentView addSubview:titleLabel];
    titleLabel.textColor=[UIColor colorWithRed:172.0/255.0 green:183.0/255.0  blue:197.0/255.0  alpha:1];
    
    return cell;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
   
    tapCellIndex=indexPath.row;
    [self removeFromSuperview];
    [[self _slideViewDelegate] PushToViewController:indexPath.row];

}


@end
