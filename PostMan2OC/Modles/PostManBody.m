//
//  PostManBody.m
//
//  Created by  梦石 on 2018/5/25
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PostManBody.h"
#import "PostManFormdata.h"


NSString *const kPostManBodyMode = @"mode";
NSString *const kPostManBodyFormdata = @"formdata";


@interface PostManBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostManBody

@synthesize mode = _mode;
@synthesize formdata = _formdata;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.mode = [self objectOrNilForKey:kPostManBodyMode fromDictionary:dict];
    NSObject *receivedPostManFormdata = [dict objectForKey:kPostManBodyFormdata];
    NSMutableArray *parsedPostManFormdata = [NSMutableArray array];
    
    if ([receivedPostManFormdata isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPostManFormdata) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPostManFormdata addObject:[PostManFormdata modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPostManFormdata isKindOfClass:[NSDictionary class]]) {
       [parsedPostManFormdata addObject:[PostManFormdata modelObjectWithDictionary:(NSDictionary *)receivedPostManFormdata]];
    }

    self.formdata = [NSArray arrayWithArray:parsedPostManFormdata];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mode forKey:kPostManBodyMode];
    NSMutableArray *tempArrayForFormdata = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.formdata) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFormdata addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFormdata addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFormdata] forKey:kPostManBodyFormdata];

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

    self.mode = [aDecoder decodeObjectForKey:kPostManBodyMode];
    self.formdata = [aDecoder decodeObjectForKey:kPostManBodyFormdata];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mode forKey:kPostManBodyMode];
    [aCoder encodeObject:_formdata forKey:kPostManBodyFormdata];
}

- (id)copyWithZone:(NSZone *)zone {
    PostManBody *copy = [[PostManBody alloc] init];
    
    
    
    if (copy) {

        copy.mode = [self.mode copyWithZone:zone];
        copy.formdata = [self.formdata copyWithZone:zone];
    }
    
    return copy;
}


@end
