//
//  PostManScript.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManScript.h"


NSString *const kPostManScriptId = @"id";
NSString *const kPostManScriptType = @"type";
NSString *const kPostManScriptExec = @"exec";


@interface PostManScript ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManScript

@synthesize id = _id;
@synthesize type = _type;
@synthesize exec = _exec;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.id = [self objectOrNilForKey:kPostManScriptId fromDictionary:dict];
            self.type = [self objectOrNilForKey:kPostManScriptType fromDictionary:dict];
            self.exec = [self objectOrNilForKey:kPostManScriptExec fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.id forKey:kPostManScriptId];
    [mutableDict setValue:self.type forKey:kPostManScriptType];
    NSMutableArray *tempArrayForExec = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.exec) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForExec addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForExec addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForExec] forKey:kPostManScriptExec];

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

    self.id = [aDecoder decodeObjectForKey:kPostManScriptId];
    self.type = [aDecoder decodeObjectForKey:kPostManScriptType];
    self.exec = [aDecoder decodeObjectForKey:kPostManScriptExec];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_id forKey:kPostManScriptId];
    [aCoder encodeObject:_type forKey:kPostManScriptType];
    [aCoder encodeObject:_exec forKey:kPostManScriptExec];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManScript *copy = [[PostManScript alloc] init];
    
    
    
    if (copy) {

        copy.id = [self.id copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.exec = [self.exec copyWithZone:zone];
    }
    
    return copy;
}


@end
