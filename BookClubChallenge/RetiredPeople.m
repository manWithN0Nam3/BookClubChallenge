//
//  RetiredFriends.m
//  BookClubChallenge
//
//  Created by Alex Santorineos on 6/3/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "RetiredPeople.h"

@implementation RetiredPeople






-(instancetype)initWithString:(NSString *)string{

    self = [super init];
    if (self) {
        self.name = string;
    }
    return self;
}


+(void)retrieveFriendsWithCompletion:(void (^)(NSArray *))complete{
    
        NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];
    
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
           NSArray *friends = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

            NSMutableArray *friendsArray = [NSMutableArray new];
            for (NSString *string in friends) {
                [friendsArray addObject:[[RetiredPeople alloc]initWithString:string]];
            }

            complete([NSArray arrayWithArray:friendsArray]);
        }];
}



@end
