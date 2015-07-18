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

@synthesize tableView, placesArray, items = _items;

- (void)viewDidLoad {
    tableView.delegate = self;
    tableView.dataSource = self;
    [super viewDidLoad];
    placesArray = [[PlacesFromParse sharedPlacesFromParse]placesArray];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"esta no loop de estabelecimentos");
    placesArray = [[PlacesFromParse sharedPlacesFromParse]placesArray];
    for (int i = 0; i < [placesArray count]; i++){
        NSLog(@"esta no loop de estabelecimentos");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)items{
    if(!_items){
        _items = @[@"Item1", @"Item2"];
    }
    return _items;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return  [placesArray count];
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"tablePeopleMapa";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
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
