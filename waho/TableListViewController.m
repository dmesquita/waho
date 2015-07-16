//
//  TableListViewController.m
//  waho
//
//  Created by Déborah Mesquita on 16/07/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "TableListViewController.h"

@interface TableListViewController ()

@end

@implementation TableListViewController

@synthesize tableView, placesArray;

- (void)viewDidLoad {
    tableView.delegate = self;
    tableView.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    for (int i = 0; i < [placesArray count]; i++){
        NSLog(@"esta no loop de estabelecimentos");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  [placesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"tablePeopleMapa";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *nomeLabel = (UILabel *)[cell viewWithTag:101];
    nomeLabel.text = [placesArray objectAtIndex:indexPath.row][@"name"];
    
    PFImageView *placeImageView = (PFImageView *)[cell viewWithTag:100];
    PFFile *imageFile = [placesArray objectAtIndex:indexPath.row][@"pictureSombra"];
    placeImageView.file = imageFile;
    [placeImageView loadInBackground];
    
    return cell;
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
