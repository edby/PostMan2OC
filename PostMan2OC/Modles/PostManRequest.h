//
//  PostManRequest.h
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostManBody, PostManUrl;

@interface PostManRequest : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PostManBody *body;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSArray *header;
@property (nonatomic, strong) PostManUrl *url;
@property (nonatomic, strong) NSString *desc;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
