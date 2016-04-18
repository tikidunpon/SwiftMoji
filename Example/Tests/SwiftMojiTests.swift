//
//  SwiftMojiTests.swift
//  SwiftMojiTests
//
//  Created by koichi tanaka on 2016/04/02.
//  Copyright © 2016年 koichi tanaka. All rights reserved.
//

import XCTest

@testable import SwiftMoji

class SwiftMojiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirst() {
        XCTAssert("abc".first() == "a")
        XCTAssert(" ".first() == " ")
        XCTAssert("".first() == "")
    }
    
    func testLast() {
        XCTAssert("abc".last() == "c")
        XCTAssert(" ".last() == " ")
        XCTAssert("".last() == "")
    }
    
    func testUppercasedFirst() {
        XCTAssertTrue("abc".uppercasedFirst() == "Abc")
        XCTAssertTrue("a".uppercasedFirst() == "A")
        XCTAssertTrue("".uppercasedFirst() == "")
        XCTAssertTrue("ABC".uppercasedFirst() == "ABC")
    }
    
    func testLowercasedFirst() {
        XCTAssertTrue("ABC".lowercasedFirst() == "aBC")
        XCTAssertTrue("abc".lowercasedFirst() == "abc")
        XCTAssertTrue("A".lowercasedFirst()   == "a")
        XCTAssertTrue("".lowercasedFirst()    == "")
    }
    
    func testIsCapitalized() {
        XCTAssertTrue("A".isCapitalized())
        XCTAssertTrue("Abc".isCapitalized())
        XCTAssertTrue("Abc Abc".isCapitalized())
        XCTAssertFalse("abc".isCapitalized())
        XCTAssertFalse("abc abc".isCapitalized())
        XCTAssertFalse("".isCapitalized())
    }
    
    func testIsAlphabet() {
        XCTAssertTrue("abc".isAlphabet())
        XCTAssertTrue("ABC".isAlphabet())
        XCTAssertFalse("".isAlphabet())
        XCTAssertFalse(" ".isAlphabet())
        XCTAssertFalse("あ".isAlphabet())
        XCTAssertFalse("a b c".isAlphabet())
    }
    
    func testIsNumeric() {
        XCTAssertTrue("-1.983388".isNumeric())
        XCTAssertTrue("-1".isNumeric())
        XCTAssertTrue("0".isNumeric())
        XCTAssertTrue("01".isNumeric())
        XCTAssertTrue("10".isNumeric())
        XCTAssertTrue("9.12345".isNumeric())
        XCTAssertTrue("86373891234.5".isNumeric())
        
        XCTAssertFalse("".isNumeric())
        XCTAssertFalse(" ".isNumeric())
        XCTAssertFalse("\n".isNumeric())
        XCTAssertFalse("\t".isNumeric())
        XCTAssertFalse("abcde".isNumeric())
    }
    
    func testIsUppercased() {
        XCTAssertTrue("A".isUppercased())
        XCTAssertTrue("ABC".isUppercased())
        XCTAssertTrue("A_B_C".isUppercased())
        XCTAssertTrue(" A B C ".isUppercased())
        
        XCTAssertFalse("a".isUppercased())
        XCTAssertFalse("aBc".isUppercased())
        XCTAssertFalse("".isUppercased())
        XCTAssertFalse(" ".isUppercased())
    }
    
    func testIsOnlyUppercased() {
        XCTAssertTrue("A".isOnlyUppercased())
        XCTAssertTrue("ABC".isOnlyUppercased())
        XCTAssertFalse("A_B_C".isOnlyUppercased())
        
        XCTAssertFalse("a".isOnlyUppercased())
        XCTAssertFalse("aBc".isOnlyUppercased())
        XCTAssertFalse("".isOnlyUppercased())
        XCTAssertFalse(" ".isOnlyUppercased())
    }
    
    func testIsLowercased() {
        XCTAssertTrue("a".isLowercased())
        XCTAssertTrue("abc".isLowercased())
        XCTAssertTrue("a_b_c".isLowercased())
        XCTAssertTrue(" a b c ".isLowercased())
        
        XCTAssertFalse("A".isLowercased())
        XCTAssertFalse("abC".isLowercased())
        XCTAssertFalse("".isLowercased())
        XCTAssertFalse(" ".isLowercased())
    }
    
    func testIsOnlyLowercased() {
        XCTAssertTrue("a".isOnlyLowercased())
        XCTAssertTrue("abc".isOnlyLowercased())
        
        XCTAssertFalse("A".isOnlyLowercased())
        XCTAssertFalse("abC".isOnlyLowercased())
        XCTAssertFalse("".isOnlyLowercased())
        XCTAssertFalse(" ".isOnlyLowercased())
    }
    
    func testCamelized() {
        XCTAssertTrue("abc_def".camelized() == "AbcDef")
        XCTAssertTrue("Abc_def".camelized() == "AbcDef")
        XCTAssertTrue("abc_def_ghi".camelized() == "AbcDefGhi")
        XCTAssertTrue("abc-Def".camelized() == "AbcDef")
        XCTAssertTrue("Abc-Def".camelized() == "AbcDef")
        XCTAssertTrue("abc def ".camelized() == "AbcDef")
        XCTAssertTrue("abc  def".camelized() == "AbcDef")
        XCTAssertTrue("ABc-def_ghi jkl".camelized() == "AbcDefGhiJkl")
        XCTAssertTrue("".camelized() == "")
    }
    
    func testIsUpperCamelized() {
        XCTAssertTrue("UserId".isUpperCamelized())
        XCTAssertTrue("UserID".isUpperCamelized())
        XCTAssertTrue("URLString".isUpperCamelized())
        XCTAssertTrue("Class2016".isUpperCamelized())
        XCTAssertTrue("Class2016Class".isUpperCamelized())
        XCTAssertTrue("UTF8String".isUpperCamelized())
        XCTAssertFalse("URL-Identifier".isUpperCamelized())
        XCTAssertFalse("User-Id".isUpperCamelized())
        XCTAssertFalse("USER".isUpperCamelized())
        XCTAssertFalse("userId".isUpperCamelized())
    }
    
    func testIsLowerCamelized() {
        XCTAssertTrue("userId".isLowerCamelized())
        XCTAssertTrue("userID".isLowerCamelized())
        XCTAssertTrue("urlString".isLowerCamelized())
        XCTAssertTrue("class2016".isLowerCamelized())
        XCTAssertTrue("class2016class".isLowerCamelized())
        XCTAssertTrue("utf8String".isLowerCamelized())
        XCTAssertFalse("uRL-Identifier".isLowerCamelized())
        XCTAssertFalse("user-id".isLowerCamelized())
        XCTAssertFalse("USER".isLowerCamelized())
        XCTAssertFalse("UserId".isLowerCamelized())
    }
    
    func testSnakecased() {
        XCTAssertTrue("abcDef".snakecased() == "abc_def")
        XCTAssertTrue("abcDefGhi".snakecased() == "abc_def_ghi")
        XCTAssertTrue("abcDef-Ghi".snakecased() == "abc_def_ghi")
        XCTAssertTrue("abc99Def-Ghi".snakecased() == "abc99_def_ghi")
        XCTAssertTrue("abc99Def-Ghi99".snakecased() == "abc99_def_ghi99")
        XCTAssertTrue("ABCDEFG".snakecased() == "abcdefg")
        XCTAssertTrue("ABC_DEF".snakecased() == "abc_def")
        XCTAssertTrue("ABC-DEF".snakecased() == "abc_def")
        XCTAssertTrue("abc-def".snakecased() == "abc_def")
        XCTAssertTrue("abc def".snakecased() == "abc_def")
        XCTAssertTrue("UserId".snakecased()  == "user_id")
        XCTAssertTrue("userId".snakecased()  == "user_id")
        XCTAssertTrue("userID".snakecased()  == "user_id")
        XCTAssertTrue("User-ID".snakecased() == "user_id")
        XCTAssertTrue("User-ID Type".snakecased() == "user_id_type")
        XCTAssertTrue("".snakecased() == "")
    }
    
    func testTrimmed() {
        // trimmed
        XCTAssertTrue("   abcdef   ".trimmed()   == "abcdef")
        XCTAssertTrue("   abc  def   ".trimmed() == "abc  def")
        XCTAssertTrue("abc  def   ".trimmed()    == "abc  def")
        XCTAssertTrue("   abc  def".trimmed()    == "abc  def")
        XCTAssertTrue(" \n  abc \n \t def \n \t".trimmed() == "abc \n \t def")
        
        // trimmedLeft
        XCTAssertTrue("   abcdef   ".trimmedLeft()   == "abcdef   ")
        XCTAssertTrue("   abc  def   ".trimmedLeft() == "abc  def   ")
        
        // trimmedRight
        XCTAssertTrue("   abcdef   ".trimmedRight()   == "   abcdef")
        XCTAssertTrue("   abc  def".trimmedRight() == "   abc  def")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            for _ in 1..<10000 {
                "A_B_C".isOnlyUppercased()
            }
        }
    }
    
}
