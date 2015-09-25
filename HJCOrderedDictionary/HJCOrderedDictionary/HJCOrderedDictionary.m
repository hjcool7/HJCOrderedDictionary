//
//  HJCOrderedDictionary.m
//  HJCOrderedDictionary
//
//  Created by hjcool7 on 15/9/24.
//  Copyright © 2015年 hjcool7. All rights reserved.
//

#import "HJCOrderedDictionary.h"

@interface HJCOrderedDictionary()

@property (nonatomic,strong) NSMutableOrderedSet *keys;
@property (nonatomic,strong) NSMutableArray *values;

@end

@implementation HJCOrderedDictionary

- (instancetype)init
{
    self = [self initWithDictArray:nil];
    return self;
}

- (instancetype)initWithDictArray:(NSArray *)dictArray
{
    self = [super init];
    if (self)
    {
        _keys = [[NSMutableOrderedSet alloc] init];
        _values = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in dictArray)
        {
            if (![dict isKindOfClass:[NSDictionary class]])
            {
                continue;
            }
            if (dict.count != 1)
            {
                continue;
            }
            [dict enumerateKeysAndObjectsUsingBlock:^(id key,id value,BOOL *stop)
             {
                 NSUInteger index = [_keys indexOfObject:key];
                 if (index == NSNotFound)
                 {
                     [_keys addObject:key];
                     [_values addObject:value];
                 }
                 else
                 {
                     _values[index] = value;
                 }
             }];
        }
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array
{
    id value = nil;
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    for (id obj in array)
    {
        if (!value)
        {
            value = obj;
        }
        else
        {
            [dictArray addObject:@{obj : value}];
            value = nil;
        }
    }
    return [self initWithDictArray:dictArray];
}
- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list varList;
    id arg;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if(firstObject)
    {
        [array addObject:firstObject];
        va_start(varList,firstObject);
        while((arg = va_arg(varList,id)))
        {
            [array addObject:arg];
        }
        va_end(varList);
    }
    return [self initWithArray:array];
}
- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    NSUInteger objectCount = objects.count;
    NSUInteger keyCount = keys.count;
    NSUInteger count = MIN(objectCount, keyCount);
    for (int i = 0;i < count;i++)
    {
        id key = keys[i];
        id object = objects[i];
        [dictArray addObject:@{key : object}];
    }
    return [self initWithDictArray:dictArray];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self)
    {
        _keys = [aDecoder decodeObjectOfClass:[NSMutableOrderedSet class] forKey:@"keys"];
        _values = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"values"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.keys forKey:@"keys"];
    [aCoder encodeObject:self.values forKey:@"values"];
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (id)copyWithZone:(NSZone *)zone
{
    HJCOrderedDictionary *copy = [[HJCOrderedDictionary alloc] init];
    copy.keys = [self.keys mutableCopy];
    copy.values = [self.values mutableCopy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    HJCMutableOrderedDictionary *copy = [[HJCMutableOrderedDictionary alloc] init];
    copy.keys = [self.keys mutableCopy];
    copy.values = [self.values mutableCopy];
    return copy;
}

- (id)objectForKey:(id)key
{
    NSUInteger index = [self.keys indexOfObject:key];
    if (index == NSNotFound)
    {
        return nil;
    }
    return self.values[index];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.values objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)object
{
    return [self.values indexOfObject:object];
}

- (NSUInteger)count
{
    return self.values.count;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [self.values countByEnumeratingWithState:state objects:buffer count:len];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsWithOptions:0 usingBlock:block];
}
- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self.values enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:^(id objValue, NSUInteger idx, BOOL *stopValue)
     {
         if (block)
         {
             block(self.keys[idx], objValue, stopValue);
         }
     }];
}

- (id)objectForKeyedSubscript:(id)key
{
    return [self objectForKey:key];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self objectAtIndex:idx];
}

- (NSOrderedSet *)allKeys
{
    return [self.keys copy];
}
- (NSArray *)allValues
{
    return [self.values copy];
}

@end

@implementation HJCMutableOrderedDictionary

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (idx < self.count)
    {
        [self.values setObject:obj atIndexedSubscript:idx];
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self setObject:obj forKey:key];
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    [self addObject:anObject forKey:aKey];
}

- (void)addObject:(id)object forKey:(id <NSCopying>)key
{
    NSUInteger index = [self.keys indexOfObject:key];
    if (index == NSNotFound)
    {
        [self.keys addObject:key];
        [self.values addObject:object];
    }
    else
    {
        self.values[index] = object;
    }
}

- (void)insertObject:(id)object forKey:(id <NSCopying>)key atIndex:(NSUInteger)index
{
    [self.keys insertObject:key atIndex:index];
    [self.values insertObject:object atIndex:index];
}

- (void)removeObjectForKey:(id)key
{
    NSUInteger index = [self.keys indexOfObject:key];
    if (index != NSNotFound)
    {
        [self.keys removeObjectAtIndex:index];
        [self.values removeObjectAtIndex:index];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.keys removeObjectAtIndex:index];
    [self.values removeObjectAtIndex:index];
}

- (void)removeAllObjects
{
    [self.keys removeAllObjects];
    [self.values removeAllObjects];
}

- (void)sortUsingComparator:(NSComparator)cmptr
{
    [self sortWithOptions:0 usingComparator:cmptr];
}
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr
{
    if (cmptr)
    {
        [self.keys sortWithOptions:opts usingComparator:^(id obj1, id obj2)
         {
             return cmptr(self[obj1],self[obj2]);
         }];
        [self.values sortWithOptions:opts usingComparator:cmptr];
    }
}

@end
