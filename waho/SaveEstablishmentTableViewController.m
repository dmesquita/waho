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
    
    NSMutableArray *savedEstablishments;

}

@synthesize activityLoadingFavs, tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerAction:) name:@"NotificationMessageEvent" object:nil];
    [activityLoadingFavs startAnimating];
    savedEstablishments = [[NSMutableArray alloc] init];
    PFQuery *queryUser = [PFQuery queryWithClassName:@"Place"];
    [queryUser whereKey:@"favorites" equalTo:[[PFUser currentUser] objectId]];
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if([objects count] > 0){
                NSLog(@"Está na lista de favoritos");
                for (int i = 0; i < [objects count]; i++){
                    NSString *nome = objects[i][@"name"];
                     NSLog(objects[i][@"name"]);
                    [savedEstablishments addObject:nome];
                };
            }else{
                NSLog(@"Nenhum favorito encontrado ao procurar lista de favoritos");
            }
        } else {
            NSLog(@"Error: %@", error);
        }
        activityLoadingFavs.hidesWhenStopped = true;
        [activityLoadingFavs stopAnimating];
    }];
    [self.tableView reloadData];
    //savedEstablishments = [NSArray arrayWithObjects:@"Biruta Bar", @"Paço do Frevo", nil];
    
}

-(void) triggerAction:(NSNotification *) notification{
//    if ([notification.object isKindOfClass:[NSArray class]])
//    {
//        NSLog(@"jksdhfkjsdhafkjhsadkljfhskadjhfkjsahdfkljhsdakfjhsadkjhfkjsdahfkjshdakjf");
//        NSArray *message = [notification object];
//        NSLog(@"jksdhfkjsdhafkjhsadkljfhskadjhfkjsahdfkljhsdakfjhsadkjhfkjsdahfkjshdakjf");
//        // do stuff here with your message data
//    }
//    else
//    {
//        NSLog(@"Error, object not recognised.");
//    }
    NSLog(@"oi");
    if ([[notification name]  isEqualToString:@"NotificationMessageEvent"]){
        NSLog(@"rodou a notification");
    }else{
        NSLog(@"socorro");
    }
    
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
