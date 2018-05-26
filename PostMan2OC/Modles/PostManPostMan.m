//
//  PostManPostMan.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManPostMan.h"
#import "PostManInfo.h"
#import "PostManItem.h"


NSString *const kPostManPostManInfo = @"info";
NSString *const kPostManPostManItem = @"item";


@interface PostManPostMan ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManPostMan

@synthesize info = _info;
@synthesize item = _item;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.info = [PostManInfo modelObjectWithDictionary:[dict objectForKey:kPostManPostManInfo]];
    NSObject *receivedPostManItem = [dict objectForKey:kPostManPostManItem];
    NSMutableArray *parsedPostManItem = [NSMutableArray array];
    
    if ([receivedPostManItem isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPostManItem) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPostManItem addObject:[PostManItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPostManItem isKindOfClass:[NSDictionary class]]) {
       [parsedPostManItem addObject:[PostManItem modelObjectWithDictionary:(NSDictionary *)receivedPostManItem]];
    }

    self.item = [NSArray arrayWithArray:parsedPostManItem];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kPostManPostManInfo];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItem] forKey:kPostManPostManItem];

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

    self.info = [aDecoder decodeObjectForKey:kPostManPostManInfo];
    self.item = [aDecoder decodeObjectForKey:kPostManPostManItem];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_info forKey:kPostManPostManInfo];
    [aCoder encodeObject:_item forKey:kPostManPostManItem];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManPostMan *copy = [[PostManPostMan alloc] init];
    
    
    
    if (copy) {

        copy.info = [self.info copyWithZone:zone];
        copy.item = [self.item copyWithZone:zone];
    }
    
    return copy;
}


@end
