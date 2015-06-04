//
//  HomeTableViewController.m
//  BookClubChallenge
//
//  Created by Alex Santorineos on 6/3/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "HomeTableViewController.h"
#import "FriendsTableViewController.h"
#import "Friend.h"
#import "AppDelegate.h"

@interface HomeTableViewController ()
@property NSMutableArray *selectedFriends;
@property Friend *friend;
@property NSManagedObjectContext *moc;
@property NSArray *friends;

@end

@implementation HomeTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    self.moc = delegate.managedObjectContext;

    [self.tableView reloadData];
//    self.selectedFriends = [[NSMutableArray alloc]init];

}

-(void)viewDidAppear:(BOOL)animated{


    self.selectedFriends = [[NSMutableArray alloc]init];
    NSLog(@"%lu------- ",(unsigned long)self.selectedFriends.count);


}
//
//-(void)load{
//    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"FriendOne"];
//    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    request.sortDescriptors = @[sortDescriptor1];
//    self.friends = [self.moc executeFetchRequest:request error:nil];
//    [self.tableView reloadData];
//}

- (void)viewWillAppear:(BOOL)animated{

    NSLog(@"%lu!!!!!!!!!!!!!! ",(unsigned long)self.selectedFriends.count);
    [self.tableView reloadData];
//    NSLog(@"%@😡",self.friend.debugDescription);

    }

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedFriends.count;


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    self.friend = [self.selectedFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = self.friend.name;
    return cell;
}


-(IBAction)unwindTo:(UIStoryboardSegue*)segue{

    FriendsTableViewController *fVc = segue.sourceViewController;

    self.selectedFriends = fVc.mutableArray;

}




@end
