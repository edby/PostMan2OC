//
//  PostManItem.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManItem.h"
#import "PostManRequest.h"
#import "PostManEvent.h"


NSString *const kPostManItemRequest = @"request";
NSString *const kPostManItemEvent = @"event";
NSString *const kPostManItemResponse = @"response";
NSString *const kPostManItemName = @"name";
NSString *const kPostManItemDesc = @"desc";
NSString *const kPostManItemItem = @"item";


@interface PostManItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManItem

@synthesize request = _request;
@synthesize event = _event;
@synthesize response = _response;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize item = _item;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.request = [PostManRequest modelObjectWithDictionary:[dict objectForKey:kPostManItemRequest]];
    NSObject *receivedPostManEvent = [dict objectForKey:kPostManItemEvent];
    NSMutableArray *parsedPostManEvent = [NSMutableArray array];
    
    if ([receivedPostManEvent isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPostManEvent) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPostManEvent addObject:[PostManEvent modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPostManEvent isKindOfClass:[NSDictionary class]]) {
       [parsedPostManEvent addObject:[PostManEvent modelObjectWithDictionary:(NSDictionary *)receivedPostManEvent]];
    }

    self.event = [NSArray arrayWithArray:parsedPostManEvent];
            self.response = [self objectOrNilForKey:kPostManItemResponse fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPostManItemName fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kPostManItemDesc fromDictionary:dict];
            self.item = [self objectOrNilForKey:kPostManItemItem fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.request dictionaryRepresentation] forKey:kPostManItemRequest];
    NSMutableArray *tempArrayForEvent = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.event) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEvent addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEvent addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEvent] forKey:kPostManItemEvent];
    NSMutableArray *tempArrayForResponse = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.response) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResponse addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResponse addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResponse] forKey:kPostManItemResponse];
    [mutableDict setValue:self.name forKey:kPostManItemName];
    [mutableDict setValue:self.desc forKey:kPostManItemDesc];
    NSMutableArray *tempArrayForItem = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.item) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItem addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItem addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItem] forKey:kPostManItemItem];

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

    self.request = [aDecoder decodeObjectForKey:kPostManItemRequest];
    self.event = [aDecoder decodeObjectForKey:kPostManItemEvent];
    self.response = [aDecoder decodeObjectForKey:kPostManItemResponse];
    self.name = [aDecoder decodeObjectForKey:kPostManItemName];
    self.desc = [aDecoder decodeObjectForKey:kPostManItemDesc];
    self.item = [aDecoder decodeObjectForKey:kPostManItemItem];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_request forKey:kPostManItemRequest];
    [aCoder encodeObject:_event forKey:kPostManItemEvent];
    [aCoder encodeObject:_response forKey:kPostManItemResponse];
    [aCoder encodeObject:_name forKey:kPostManItemName];
    [aCoder encodeObject:_desc forKey:kPostManItemDesc];
    [aCoder encodeObject:_item forKey:kPostManItemItem];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManItem *copy = [[PostManItem alloc] init];
    
    
    
    if (copy) {

        copy.request = [self.request copyWithZone:zone];
        copy.event = [self.event copyWithZone:zone];
        copy.response = [self.response copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
        copy.item = [self.item copyWithZone:zone];
    }
    
    return copy;
}


@end
