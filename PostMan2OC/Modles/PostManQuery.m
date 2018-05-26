//
//  PostManQuery.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManQuery.h"


NSString *const kPostManQueryKey = @"key";
NSString *const kPostManQueryValue = @"value";
NSString *const kPostManQueryDesc = @"desc";


@interface PostManQuery ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManQuery

@synthesize key = _key;
@synthesize value = _value;
@synthesize desc = _desc;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.key = [self objectOrNilForKey:kPostManQueryKey fromDictionary:dict];
            self.value = [self objectOrNilForKey:kPostManQueryValue fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kPostManQueryDesc fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.key forKey:kPostManQueryKey];
    [mutableDict setValue:self.value forKey:kPostManQueryValue];
    [mutableDict setValue:self.desc forKey:kPostManQueryDesc];

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

    self.key = [aDecoder decodeObjectForKey:kPostManQueryKey];
    self.value = [aDecoder decodeObjectForKey:kPostManQueryValue];
    self.desc = [aDecoder decodeObjectForKey:kPostManQueryDesc];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_key forKey:kPostManQueryKey];
    [aCoder encodeObject:_value forKey:kPostManQueryValue];
    [aCoder encodeObject:_desc forKey:kPostManQueryDesc];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManQuery *copy = [[PostManQuery alloc] init];
    
    
    
    if (copy) {

        copy.key = [self.key copyWithZone:zone];
        copy.value = [self.value copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
    }
    
    return copy;
}


@end
