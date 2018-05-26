//
//  PostManFormdata.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManFormdata.h"


NSString *const kPostManFormdataEquals = @"equals";
NSString *const kPostManFormdataValue = @"value";
NSString *const kPostManFormdataKey = @"key";
NSString *const kPostManFormdataType = @"type";
NSString *const kPostManFormdataDesc = @"desc";


@interface PostManFormdata ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManFormdata

@synthesize equals = _equals;
@synthesize value = _value;
@synthesize key = _key;
@synthesize type = _type;
@synthesize desc = _desc;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.equals = [[self objectOrNilForKey:kPostManFormdataEquals fromDictionary:dict] boolValue];
            self.value = [self objectOrNilForKey:kPostManFormdataValue fromDictionary:dict];
            self.key = [self objectOrNilForKey:kPostManFormdataKey fromDictionary:dict];
            self.type = [self objectOrNilForKey:kPostManFormdataType fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kPostManFormdataDesc fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.equals] forKey:kPostManFormdataEquals];
    [mutableDict setValue:self.value forKey:kPostManFormdataValue];
    [mutableDict setValue:self.key forKey:kPostManFormdataKey];
    [mutableDict setValue:self.type forKey:kPostManFormdataType];
    [mutableDict setValue:self.desc forKey:kPostManFormdataDesc];

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

    self.equals = [aDecoder decodeBoolForKey:kPostManFormdataEquals];
    self.value = [aDecoder decodeObjectForKey:kPostManFormdataValue];
    self.key = [aDecoder decodeObjectForKey:kPostManFormdataKey];
    self.type = [aDecoder decodeObjectForKey:kPostManFormdataType];
    self.desc = [aDecoder decodeObjectForKey:kPostManFormdataDesc];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_equals forKey:kPostManFormdataEquals];
    [aCoder encodeObject:_value forKey:kPostManFormdataValue];
    [aCoder encodeObject:_key forKey:kPostManFormdataKey];
    [aCoder encodeObject:_type forKey:kPostManFormdataType];
    [aCoder encodeObject:_desc forKey:kPostManFormdataDesc];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManFormdata *copy = [[PostManFormdata alloc] init];
    
    
    
    if (copy) {

        copy.equals = self.equals;
        copy.value = [self.value copyWithZone:zone];
        copy.key = [self.key copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
    }
    
    return copy;
}


@end
