//
//  SaveEstablishmentTableViewController.m
//  waho
//
//  Created by José Luiz Correia Neto on 15/06/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "SaveEstablishmentTableViewController.h"

@interface SaveEstablishmentTableViewController ()

@end

@implementation SaveEstablishmentTableViewController {
    
    NSArray *savedEstablishments;

}

@synthesize activityLoadingFavs;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [activityLoadingFavs startAnimating];
    
    PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
    [queryUser whereKey:@"favorites" equalTo:[[PFUser currentUser] objectId]];
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if([objects count] > 0){
                NSLog(@"Está na lista de favoritos");
                for (int i = 0; i < [objects count]; i++){
                     NSLog(objects[i][@"name"]);
                };
            }else{
                NSLog(@"Nenhum favorito encontrado ao procurar lista de favoritos");
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    savedEstablishments = [NSArray arrayWithObjects:@"Biruta Bar", @"Paço do Frevo", nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  [savedEstablishments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SavedEstablishmentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [savedEstablishments objectAtIndex:indexPath.row];
    return cell;
}


@end
