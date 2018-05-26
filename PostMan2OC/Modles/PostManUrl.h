//
//  PostManUrl.h
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PostManUrl : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *raw;
@property (nonatomic, strong) NSArray *path;
@property (nonatomic, strong) NSArray *query;
@property (nonatomic, strong) NSString *protocol;
@property (nonatomic, strong) NSArray *host;
@property (nonatomic, strong) NSString *port;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
