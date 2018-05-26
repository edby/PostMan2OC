//
//  PostManEvent.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManEvent.h"
#import "PostManScript.h"


NSString *const kPostManEventScript = @"script";
NSString *const kPostManEventListen = @"listen";


@interface PostManEvent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManEvent

@synthesize script = _script;
@synthesize listen = _listen;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.script = [PostManScript modelObjectWithDictionary:[dict objectForKey:kPostManEventScript]];
            self.listen = [self objectOrNilForKey:kPostManEventListen fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.script dictionaryRepresentation] forKey:kPostManEventScript];
    [mutableDict setValue:self.listen forKey:kPostManEventListen];

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

    self.script = [aDecoder decodeObjectForKey:kPostManEventScript];
    self.listen = [aDecoder decodeObjectForKey:kPostManEventListen];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_script forKey:kPostManEventScript];
    [aCoder encodeObject:_listen forKey:kPostManEventListen];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManEvent *copy = [[PostManEvent alloc] init];
    
    
    
    if (copy) {

        copy.script = [self.script copyWithZone:zone];
        copy.listen = [self.listen copyWithZone:zone];
    }
    
    return copy;
}


@end
