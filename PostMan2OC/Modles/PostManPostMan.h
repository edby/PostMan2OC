//
//  PostManPostMan.h
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostManInfo;

@interface PostManPostMan : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PostManInfo *info;
@property (nonatomic, strong) NSArray *item;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
