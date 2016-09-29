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
    
    func testSecond() {
        XCTAssert("abc".second() == "b")
        XCTAssert("ab".second() == "b")
        XCTAssert("a".second() == "")
        XCTAssert(" ".second() == "")
        XCTAssert("".second() == "")
    }
    
    func testLast() {
        XCTAssert("abc".last() == "c")
        XCTAssert(" ".last() == " ")
        XCTAssert("".last() == "")
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
    
    func testDropFirst() {
        XCTAssertTrue("abc".dropFirst() == "bc")
        XCTAssertTrue("abc".dropFirst(2) == "c")
    }
    
    func testDropLast() {
        XCTAssertTrue("abc".dropLast() == "ab")
        XCTAssertTrue("abc".dropLast(2) == "a")
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
        XCTAssertFalse("A_B_C".isUppercased())
        
        XCTAssertFalse("a".isUppercased())
        XCTAssertFalse("aBc".isUppercased())
        XCTAssertFalse("".isUppercased())
        XCTAssertFalse(" ".isUppercased())
    }
    
    func testIsLowercased() {
        XCTAssertTrue("a".isLowercased())
        XCTAssertTrue("abc".isLowercased())
        
        XCTAssertFalse("A".isLowercased())
        XCTAssertFalse("abC".isLowercased())
        XCTAssertFalse("".isLowercased())
        XCTAssertFalse(" ".isLowercased())
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
        XCTAssertTrue("   ".trimmedLeft() == "   ")
        
        // trimmedRight
        XCTAssertTrue("   abcdef   ".trimmedRight()   == "   abcdef")
        XCTAssertTrue("   abc  def".trimmedRight() == "   abc  def")
        XCTAssertTrue("   ".trimmedRight() == "   ")
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

    func testIsHiragana() {
        XCTAssertTrue("あいうえお".isHiragana())
        XCTAssertTrue("\u{3041}".isHiragana())
        XCTAssertTrue("ぁ".isHiragana())
        XCTAssertTrue("ゖ".isHiragana())
        
        XCTAssertFalse("abc".isHiragana())
        XCTAssertFalse("\u{3040}".isHiragana())
        XCTAssertFalse("\u{3097}".isHiragana())
        XCTAssertFalse("".isHiragana())
    }
    
    func testIsKatakana() {
        XCTAssertTrue("アイウエオ".isKatakana())
        XCTAssertTrue("\u{30A1}".isKatakana())
        XCTAssertTrue("\u{30FA}".isKatakana())
        XCTAssertTrue("ァ".isKatakana())
        XCTAssertTrue("ヺ".isKatakana())
        
        XCTAssertFalse("abc".isKatakana())
        XCTAssertFalse("\u{30A0}".isKatakana())
        XCTAssertFalse("\u{30FB}".isKatakana())
        XCTAssertFalse("".isKatakana())
    }
    
    func testRemoveRedundantWhitespace() {
        XCTAssertTrue("abc    def".removeRedundantWhitespace() == "abc def")
        XCTAssertTrue("abcdef".removeRedundantWhitespace() == "abcdef")
        XCTAssertTrue("  abcdef".removeRedundantWhitespace() == "abcdef")
    }
    
    func testSnakecasedPerformance() {
        self.measure {
            for _ in 0..<10000 {
                "UserId".snakecased()
            }
        }
    }
    
}
