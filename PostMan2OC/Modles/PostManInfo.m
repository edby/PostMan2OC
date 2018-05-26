//
//  PostManInfo.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManInfo.h"


NSString *const kPostManInfoName = @"name";
NSString *const kPostManInfoPostmanId = @"_postman_id";
NSString *const kPostManInfoSchema = @"schema";


@interface PostManInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManInfo

@synthesize name = _name;
@synthesize _postman_id = __postman_id;
@synthesize schema = _schema;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kPostManInfoName fromDictionary:dict];
            self._postman_id = [self objectOrNilForKey:kPostManInfoPostmanId fromDictionary:dict];
            self.schema = [self objectOrNilForKey:kPostManInfoSchema fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kPostManInfoName];
    [mutableDict setValue:self._postman_id forKey:kPostManInfoPostmanId];
    [mutableDict setValue:self.schema forKey:kPostManInfoSchema];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:kPostManInfoName];
    self._postman_id = [aDecoder decodeObjectForKey:kPostManInfoPostmanId];
    self.schema = [aDecoder decodeObjectForKey:kPostManInfoSchema];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kPostManInfoName];
    [aCoder encodeObject:__postman_id forKey:kPostManInfoPostmanId];
    [aCoder encodeObject:_schema forKey:kPostManInfoSchema];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManInfo *copy = [[PostManInfo alloc] init];
    
    
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy._postman_id = [self._postman_id copyWithZone:zone];
        copy.schema = [self.schema copyWithZone:zone];
    }
    
    return copy;
}


@end
