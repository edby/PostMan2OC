//
//  PostManEvent.h
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostManScript;

@interface PostManEvent : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PostManScript *script;
@property (nonatomic, strong) NSString *listen;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
