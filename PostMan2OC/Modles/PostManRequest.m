//
//  PostManRequest.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManRequest.h"
#import "PostManBody.h"
#import "PostManUrl.h"


NSString *const kPostManRequestBody = @"body";
NSString *const kPostManRequestMethod = @"method";
NSString *const kPostManRequestHeader = @"header";
NSString *const kPostManRequestUrl = @"url";
NSString *const kPostManRequestDesc = @"desc";


@interface PostManRequest ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManRequest

@synthesize body = _body;
@synthesize method = _method;
@synthesize header = _header;
@synthesize url = _url;
@synthesize desc = _desc;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.body = [PostManBody modelObjectWithDictionary:[dict objectForKey:kPostManRequestBody]];
            self.method = [self objectOrNilForKey:kPostManRequestMethod fromDictionary:dict];
            self.header = [self objectOrNilForKey:kPostManRequestHeader fromDictionary:dict];
            self.url = [PostManUrl modelObjectWithDictionary:[dict objectForKey:kPostManRequestUrl]];
            self.desc = [self objectOrNilForKey:kPostManRequestDesc fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kPostManRequestBody];
    [mutableDict setValue:self.method forKey:kPostManRequestMethod];
    NSMutableArray *tempArrayForHeader = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.header) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHeader addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHeader addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHeader] forKey:kPostManRequestHeader];
    [mutableDict setValue:[self.url dictionaryRepresentation] forKey:kPostManRequestUrl];
    [mutableDict setValue:self.desc forKey:kPostManRequestDesc];

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

    self.body = [aDecoder decodeObjectForKey:kPostManRequestBody];
    self.method = [aDecoder decodeObjectForKey:kPostManRequestMethod];
    self.header = [aDecoder decodeObjectForKey:kPostManRequestHeader];
    self.url = [aDecoder decodeObjectForKey:kPostManRequestUrl];
    self.desc = [aDecoder decodeObjectForKey:kPostManRequestDesc];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kPostManRequestBody];
    [aCoder encodeObject:_method forKey:kPostManRequestMethod];
    [aCoder encodeObject:_header forKey:kPostManRequestHeader];
    [aCoder encodeObject:_url forKey:kPostManRequestUrl];
    [aCoder encodeObject:_desc forKey:kPostManRequestDesc];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManRequest *copy = [[PostManRequest alloc] init];
    
    
    
    if (copy) {

        copy.body = [self.body copyWithZone:zone];
        copy.method = [self.method copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
    }
    
    return copy;
}


@end
