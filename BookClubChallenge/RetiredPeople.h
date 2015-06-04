//
//  RetiredFriends.h
//  BookClubChallenge
//
//  Created by Alex Santorineos on 6/3/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetiredPeople : NSObject
@property NSString *name;



-(instancetype)initWithString:(NSString *)string;


+(void)retrieveFriendsWithCompletion:(void (^)(NSArray *))complete;

@end
