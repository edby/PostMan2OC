//
//  PostManItem.h
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostManRequest;

@interface PostManItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PostManRequest *request;
@property (nonatomic, strong) NSArray *event;
@property (nonatomic, strong) NSArray *response;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray *item;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
