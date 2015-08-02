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
        _items = [[PlacesFromParse sharedPlacesFromParse]placesArray];
    }
    return _items;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return  [placesArray count];
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *simpleTableIdentifier = @"tablePeopleMapa";
    ListViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LVCell"];
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil ] forCellReuseIdentifier:@"LVCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"LVCell"];
        //cell.lbTitlePlace = [self.items objectAtIndex:indexPath.row];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    //cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
       return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListViewTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.lbTitlePlace.text = [self.items objectAtIndex:indexPath.row][@"name"];
    PFFile *imageFile = [self.items objectAtIndex:indexPath.row][@"pictureSombra"];
    cell.imgBackground.file = imageFile;
    [cell.imgBackground loadInBackground];
    
    /* Category icon */
    if([[self.items objectAtIndex:indexPath.row][@"categoria"]  isEqual: @"Feira"]){
        cell.imgCategory.image = [UIImage imageNamed:@"icone feira"];
    }else if([[self.items objectAtIndex:indexPath.row][@"categoria"]  isEqual: @"Mercado"]){
        cell.imgCategory.image = [UIImage imageNamed:@"icone artesanato"];
    }else if([[self.items objectAtIndex:indexPath.row][@"categoria"]  isEqual: @"Restaurante"]){
        cell.imgCategory.image = [UIImage imageNamed:@"icone restaurante"];
    }
    
    if ([PFUser currentUser] != nil) {
        if([[self.items objectAtIndex:indexPath.row][@"favorites"] containsObject:[[PFUser currentUser] objectId]]){
            cell.imgFav.image = [UIImage imageNamed:@"bandeira_salvar"];
        }else{
            cell.imgFav.image = [UIImage imageNamed:@"bandeira_nao_salvo"];
        }
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"oi gente");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EstablishmentViewController *establishmentVC = (EstablishmentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Establishment"];
    establishmentVC.place = [self.items objectAtIndex:indexPath.row];
    establishmentVC.favoritedPlaces = [[PlacesFromParse sharedPlacesFromParse]favoritedPlaces];
    establishmentVC.visitedPlaces = [[PlacesFromParse sharedPlacesFromParse]visitedPlaces];
    [self.navigationController pushViewController:establishmentVC animated:YES];
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
