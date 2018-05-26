//
//  PostManFormdata.h
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PostManFormdata : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL equals;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *desc;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
