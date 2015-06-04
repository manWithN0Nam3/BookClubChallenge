//
//  FriendOne.h
//  BookClubChallenge
//
//  Created by Alex Santorineos on 6/3/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend;

@interface FriendOne : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *friend;
@end

@interface FriendOne (CoreDataGeneratedAccessors)

- (void)addFriendObject:(Friend *)value;
- (void)removeFriendObject:(Friend *)value;
- (void)addFriend:(NSSet *)values;
- (void)removeFriend:(NSSet *)values;

@end
