//
//  PostManHeader.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManHeader.h"


NSString *const kPostManHeaderKey = @"key";
NSString *const kPostManHeaderValue = @"value";


@interface PostManHeader ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManHeader

@synthesize key = _key;
@synthesize value = _value;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.key = [self objectOrNilForKey:kPostManHeaderKey fromDictionary:dict];
            self.value = [self objectOrNilForKey:kPostManHeaderValue fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.key forKey:kPostManHeaderKey];
    [mutableDict setValue:self.value forKey:kPostManHeaderValue];

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

    self.key = [aDecoder decodeObjectForKey:kPostManHeaderKey];
    self.value = [aDecoder decodeObjectForKey:kPostManHeaderValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_key forKey:kPostManHeaderKey];
    [aCoder encodeObject:_value forKey:kPostManHeaderValue];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManHeader *copy = [[PostManHeader alloc] init];
    
    
    
    if (copy) {

        copy.key = [self.key copyWithZone:zone];
        copy.value = [self.value copyWithZone:zone];
    }
    
    return copy;
}


@end
