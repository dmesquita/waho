//
//  tableViewEstablishmentTableViewController.m
//  waho
//
//  Created by José Luiz Correia Neto on 15/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "ListEstablishmentTableViewController.h"

@interface ListEstablishmentTableViewController ()

@end

@implementation ListEstablishmentTableViewController {
    
    NSArray *establishments;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initialize table data
    establishments = [NSArray arrayWithObjects:@"Biruta Bar", @"Paço do Frevo", @"Francisco Brennand", @"Ricardo Brennand", @"Bode do Nô", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  [establishments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"EstablishmentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [establishments objectAtIndex:indexPath.row];
    return cell;
}


@end
