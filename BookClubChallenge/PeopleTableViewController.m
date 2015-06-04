//
//  FriendsTableViewController.m
//  BookClubChallenge
//
//  Created by Alex Santorineos on 6/3/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "PeopleTableViewController.h"
#import "RetiredPeople.h"
#import "AppDelegate.h"
#import "People.h"

@interface PeopleTableViewController ()
@property (nonatomic)  NSArray* friends;
@property NSManagedObjectContext *moc;
@property NSArray *retiredFriends;




@end

@implementation PeopleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

//    [self loadFriends];
//
//    [self.tableView reloadData];
//
    [RetiredPeople retrieveFriendsWithCompletion:^(NSArray *array) {
        self.retiredFriends = array;
        [self populateWithRetiredHeroesIfEmpty];
        [self.tableView reloadData];

    }];

    [self loadFriends];

}

-(void)setFriends:(NSArray *)friends{

    _friends = friends;
    [self.tableView reloadData];

}

-(void)populateWithRetiredHeroesIfEmpty
{
    if (self.friends.count == 0) {
        for (RetiredPeople *retiredFriends in self.retiredFriends) {
            NSManagedObject *friend = [NSEntityDescription insertNewObjectForEntityForName:@"People" inManagedObjectContext:self.moc];
            [friend setValue:retiredFriends.name forKey:@"name"];
            [self.moc save:nil];
            [self loadFriends];
        }
    }
}


-(void)loadFriends{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"People"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor1];
    self.friends = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}


#pragma mark - delegate Method


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//        [self.friendddd removeSuperheroObject:[self.friends objectAtIndex:indexPath.row]];
        [self.moc save:nil];
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
//        [self.friendddd addSuperheroObject:[self.friends objectAtIndex:indexPath.row]];
        [self.moc save:nil];
    }

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.moc deleteObject:[self.friends objectAtIndex:indexPath.row]];
//        [tableView beginUpdates];
//        id tmp = [self.friends mutableCopy];
//        [tmp removeObjectAtIndex:indexPath.row];
//        self.friends = [tmp copy];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        [tableView endUpdates];
//        [self.moc save:nil];
//
//    }



    People *rGot = [self.friends objectAtIndex:indexPath.row];

    [self.moc deleteObject:rGot];
    
    [self loadFriends];
    
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell" forIndexPath:indexPath];
    People *friend = [self.friends objectAtIndex:indexPath.row];
    
    cell.textLabel.text = friend.name;
    return cell;
}


-(IBAction)unwindMe:(UIStoryboardSegue *)segue{

    [self loadFriends];
    [self.tableView reloadData];
    
    
}
@end
