//
//  HJCMutableOrderedDictionaryTests.m
//  HJCOrderedDictionary
//
//  Created by 季成 on 15/9/25.
//  Copyright © 2015年 hjcool7. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HJCOrderedDictionary.h"

@interface HJCMutableOrderedDictionaryTests : XCTestCase

@end

@implementation HJCMutableOrderedDictionaryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddObject
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] init];
    [dict addObject:@"v1" forKey:@"k1"];
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    [dict addObject:@"v2" forKey:@"k1"];
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v2"]);
}

- (void)testInsertObject
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] init];
    [dict addObject:@"v2" forKey:@"k2"];
    [dict insertObject:@"v1" forKey:@"k1" atIndex:0];
    XCTAssertEqual(dict.count, 2);
    XCTAssertTrue([dict[0] isEqualToString:@"v1"]);
}

- (void)testRemoveObjectForKey
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] initWithDictArray:@[@{@"k1" : @"v1"}, @{@"k2" : @"v2"}]];
    [dict removeObjectForKey:@"k1"];
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[0] isEqualToString:@"v2"]);
}

- (void)testRemoveAllObject
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] initWithDictArray:@[@{@"k1" : @"v1"}, @{@"k2" : @"v2"}]];
    [dict removeAllObjects];
    XCTAssertEqual(dict.count, 0);
}

- (void)testRemoveObjectAtIndex
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] initWithDictArray:@[@{@"k1" : @"v1"}, @{@"k2" : @"v2"}]];
    [dict removeObjectAtIndex:0];
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[0] isEqualToString:@"v2"]);
}

- (void)testSetObject
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] init];
    [dict setObject:@"v1" forKey:@"k1"];
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    [dict setObject:@"v2" forKey:@"k1"];
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v2"]);
}

- (void)testSetObjectForKeyedSubscript
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] init];
    dict[@"k1"] = @"v1";
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    dict[@"k1"] = @"v2";
    XCTAssertEqual(dict.count, 1);
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v2"]);
}

- (void)testSetObjectForKeyedSubscriptAtIndexedSubscript
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] init];
    dict[0] = @"v1";
    XCTAssertEqual(dict.count, 0);
    dict[@"k1"] = @"v1";
    dict[0] = @"v2";
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v2"]);
}

- (void)testSort
{
    HJCMutableOrderedDictionary *dict = [[HJCMutableOrderedDictionary alloc] initWithDictArray:@[@{@"k2" : @"v2"}, @{@"k1" : @"v1"}]];
    [dict sortUsingComparator:nil];
    XCTAssertTrue([dict[0] isEqualToString:@"v2"]);
    [dict sortUsingComparator:^(id obj1,id obj2)
    {
        return [obj1 compare:obj2];
    }];
    XCTAssertTrue([dict[0] isEqualToString:@"v1"]);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
