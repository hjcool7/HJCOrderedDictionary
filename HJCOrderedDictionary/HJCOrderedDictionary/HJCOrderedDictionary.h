//
//  HJCOrderedDictionary.h
//  HJCOrderedDictionary
//
//  Created by 季成 on 15/9/24.
//  Copyright © 2015年 季成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCOrderedDictionary<__covariant KeyType, __covariant ObjectType> : NSObject<NSCopying,NSMutableCopying,NSFastEnumeration,NSSecureCoding>

- (instancetype)initWithDictArray:(NSArray *)dictArray NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithObjects:(NSArray<ObjectType> *)objects forKeys:(NSArray<KeyType <NSCopying>> *)keys;


- (ObjectType)objectForKey:(KeyType)key;
- (ObjectType)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(ObjectType)object;
- (NSUInteger)count;

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;
- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

- (ObjectType)objectForKeyedSubscript:(KeyType)key;
- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;

- (NSOrderedSet *)allKeys;
- (NSArray *)allValues;

@end


@interface HJCMutableOrderedDictionary<__covariant KeyType, __covariant ObjectType> : HJCOrderedDictionary<KeyType,ObjectType>

- (void)addObject:(ObjectType)object forKey:(KeyType <NSCopying>)key;
- (void)insertObject:(ObjectType)object forKey:(KeyType <NSCopying>)key atIndex:(NSUInteger)index;
- (void)removeObjectForKey:(KeyType)key;
- (void)removeAllObjects;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
- (void)setObject:(ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key;
- (void)setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx;

- (void)sortUsingComparator:(NSComparator)cmptr;
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

@end