//
//  PostManUrl.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManUrl.h"
#import "PostManQuery.h"


NSString *const kPostManUrlRaw = @"raw";
NSString *const kPostManUrlPath = @"path";
NSString *const kPostManUrlQuery = @"query";
NSString *const kPostManUrlProtocol = @"protocol";
NSString *const kPostManUrlHost = @"host";
NSString *const kPostManUrlPort = @"port";


@interface PostManUrl ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManUrl

@synthesize raw = _raw;
@synthesize path = _path;
@synthesize query = _query;
@synthesize protocol = _protocol;
@synthesize host = _host;
@synthesize port = _port;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.raw = [self objectOrNilForKey:kPostManUrlRaw fromDictionary:dict];
            self.path = [self objectOrNilForKey:kPostManUrlPath fromDictionary:dict];
    NSObject *receivedPostManQuery = [dict objectForKey:kPostManUrlQuery];
    NSMutableArray *parsedPostManQuery = [NSMutableArray array];
    
    if ([receivedPostManQuery isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPostManQuery) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPostManQuery addObject:[PostManQuery modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPostManQuery isKindOfClass:[NSDictionary class]]) {
       [parsedPostManQuery addObject:[PostManQuery modelObjectWithDictionary:(NSDictionary *)receivedPostManQuery]];
    }

    self.query = [NSArray arrayWithArray:parsedPostManQuery];
            self.protocol = [self objectOrNilForKey:kPostManUrlProtocol fromDictionary:dict];
            self.host = [self objectOrNilForKey:kPostManUrlHost fromDictionary:dict];
            self.port = [self objectOrNilForKey:kPostManUrlPort fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.raw forKey:kPostManUrlRaw];
    NSMutableArray *tempArrayForPath = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.path) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPath addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPath addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPath] forKey:kPostManUrlPath];
    NSMutableArray *tempArrayForQuery = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.query) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForQuery addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForQuery addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForQuery] forKey:kPostManUrlQuery];
    [mutableDict setValue:self.protocol forKey:kPostManUrlProtocol];
    NSMutableArray *tempArrayForHost = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.host) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHost addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHost addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHost] forKey:kPostManUrlHost];
    [mutableDict setValue:self.port forKey:kPostManUrlPort];

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

    self.raw = [aDecoder decodeObjectForKey:kPostManUrlRaw];
    self.path = [aDecoder decodeObjectForKey:kPostManUrlPath];
    self.query = [aDecoder decodeObjectForKey:kPostManUrlQuery];
    self.protocol = [aDecoder decodeObjectForKey:kPostManUrlProtocol];
    self.host = [aDecoder decodeObjectForKey:kPostManUrlHost];
    self.port = [aDecoder decodeObjectForKey:kPostManUrlPort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_raw forKey:kPostManUrlRaw];
    [aCoder encodeObject:_path forKey:kPostManUrlPath];
    [aCoder encodeObject:_query forKey:kPostManUrlQuery];
    [aCoder encodeObject:_protocol forKey:kPostManUrlProtocol];
    [aCoder encodeObject:_host forKey:kPostManUrlHost];
    [aCoder encodeObject:_port forKey:kPostManUrlPort];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManUrl *copy = [[PostManUrl alloc] init];
    
    
    
    if (copy) {

        copy.raw = [self.raw copyWithZone:zone];
        copy.path = [self.path copyWithZone:zone];
        copy.query = [self.query copyWithZone:zone];
        copy.protocol = [self.protocol copyWithZone:zone];
        copy.host = [self.host copyWithZone:zone];
        copy.port = [self.port copyWithZone:zone];
    }
    
    return copy;
}


@end
