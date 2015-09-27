//
//  HJCOrderedDictionaryTests.m
//  HJCOrderedDictionaryTests
//
//  Created by hjcool7 on 15/9/25.
//  Copyright © 2015年 hjcool7. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HJCOrderedDictionary.h"

@interface HJCOrderedDictionaryTests : XCTestCase

@end

@implementation HJCOrderedDictionaryTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit
{
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] init];
        XCTAssertEqual(dict.count, 0);
    }
}

- (void)testInitWithDictArray
{
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithDictArray:nil];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithDictArray:@[@{@"k1" : @"v1"}]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithDictArray:@[@{@"k1" : @"v1", @"k2" : @"v2"}]];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithDictArray:@[@"k1"]];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithDictArray:@[@"k",@{@"k1" : @"v1", @"k2" : @"v2"},@{@"k3" : @"v3"}]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k3"] isEqualToString:@"v3"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithDictArray:@[@{@"k1" : @"v1"}, @{@"k1" : @"v2"}]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v2"]);
    }
}

- (void)testInitWithArray
{
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithArray:nil];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithArray:@[@"v1"]];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithArray:@[@"v1",@"k1"]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithArray:@[@"v1",@"k1",@"v2"]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithArray:@[@"v1",@"k1",@"v2",@"k2"]];
        XCTAssertEqual(dict.count, 2);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
        XCTAssertTrue([dict[@"k2"] isEqualToString:@"v2"]);
    }
}

- (void)testInitWithObjectsAndKeys
{
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjectsAndKeys:nil];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjectsAndKeys:@"v1",nil];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjectsAndKeys:@"v1",@"k1",nil];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjectsAndKeys:@"v1",@"k1",@"v2",nil];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjectsAndKeys:@"v1",@"k1",@"v2",@"k2",nil];
        XCTAssertEqual(dict.count, 2);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
        XCTAssertTrue([dict[@"k2"] isEqualToString:@"v2"]);
    }
}

- (void)testInitWithObjectsForKeys
{
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:nil forKeys:nil];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1"] forKeys:nil];
        XCTAssertEqual(dict.count, 0);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1"] forKeys:@[@"k1"]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1"]];
        XCTAssertEqual(dict.count, 1);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    }
    
    {
        HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
        XCTAssertEqual(dict.count, 2);
        XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
        XCTAssertTrue([dict[@"k2"] isEqualToString:@"v2"]);
    }
}

- (void)testObjectForKey
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    XCTAssertTrue([[dict objectForKey:@"k1"] isEqualToString:@"v1"]);
    XCTAssertTrue([[dict objectForKey:@"k2"] isEqualToString:@"v2"]);
    XCTAssertNil([dict objectForKey:@"k3"]);
    
    XCTAssertTrue([dict[@"k1"] isEqualToString:@"v1"]);
    XCTAssertTrue([dict[@"k2"] isEqualToString:@"v2"]);
    XCTAssertNil(dict[@"k3"]);
}

- (void)testObjectAtIndex
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    XCTAssertTrue([[dict objectAtIndex:0] isEqualToString:@"v1"]);
    XCTAssertTrue([[dict objectAtIndex:1] isEqualToString:@"v2"]);
    XCTAssertThrows([dict objectAtIndex:2]);
    
    XCTAssertTrue([dict[0] isEqualToString:@"v1"]);
    XCTAssertTrue([dict[1] isEqualToString:@"v2"]);
    XCTAssertThrows(dict[2]);
}

- (void)testIndexOfObject
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    XCTAssertEqual([dict indexOfObject:@"v1"], 0);
    XCTAssertEqual([dict indexOfObject:@"v2"], 1);
    XCTAssertEqual([dict indexOfObject:@"v3"], NSNotFound);
}

- (void)testEnumerateKeysAndObjectsWithOptions
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    XCTAssertNoThrow([dict enumerateKeysAndObjectsUsingBlock:nil]);
    __block int count = 0;
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop)
    {
        count++;
        if (count == 1)
        {
            XCTAssertTrue([key isEqualToString:@"k1"]);
            XCTAssertTrue([value isEqualToString:@"v1"]);
        }
        if (count == 2)
        {
            XCTAssertTrue([key isEqualToString:@"k2"]);
            XCTAssertTrue([value isEqualToString:@"v2"]);
        }
    }];
    
    XCTAssertEqual(count, 2);
}

- (void)testAllKeys
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    NSOrderedSet *keys = [dict allKeys];
    XCTAssertEqual(keys.count, 2);
    XCTAssertEqual(keys[0], @"k1");
    XCTAssertEqual(keys[1], @"k2");
}

- (void)testAllValues
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    NSArray *values = [dict allValues];
    XCTAssertEqual(values.count, 2);
    XCTAssertEqual(values[0], @"v1");
    XCTAssertEqual(values[1], @"v2");
}

- (void)testCopy
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    HJCOrderedDictionary *copyDict = [dict copy];
    XCTAssertEqual(copyDict.count, 2);
    XCTAssertTrue([copyDict[@"k1"] isEqualToString:@"v1"]);
    XCTAssertTrue([copyDict[@"k2"] isEqualToString:@"v2"]);
}

- (void)testMutableCopy
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    HJCOrderedDictionary *copyDict = [dict mutableCopy];
    XCTAssertTrue([copyDict isKindOfClass:[HJCMutableOrderedDictionary class]]);
    XCTAssertEqual(copyDict.count, 2);
    XCTAssertTrue([copyDict[@"k1"] isEqualToString:@"v1"]);
    XCTAssertTrue([copyDict[@"k2"] isEqualToString:@"v2"]);
}

- (void)testCoding
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    HJCOrderedDictionary *copyDict = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:dict]];
    XCTAssertEqual(copyDict.count, 2);
    XCTAssertTrue([copyDict[@"k1"] isEqualToString:@"v1"]);
    XCTAssertTrue([copyDict[@"k2"] isEqualToString:@"v2"]);
    XCTAssertTrue([HJCOrderedDictionary supportsSecureCoding]);
}

- (void)testForeach
{
    HJCOrderedDictionary *dict = [[HJCOrderedDictionary alloc] initWithObjects:@[@"v1",@"v2"] forKeys:@[@"k1",@"k2"]];
    XCTAssertNoThrow([dict enumerateKeysAndObjectsUsingBlock:nil]);
    int count = 0;
    
    for (id value in dict)
    {
        count++;
        if (count == 1)
        {
            XCTAssertTrue([value isEqualToString:@"v1"]);
        }
        if (count == 2)
        {
            XCTAssertTrue([value isEqualToString:@"v2"]);
        }
    }
    
    XCTAssertEqual(count, 2);
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
