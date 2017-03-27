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
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHiragana() {
        let hiragana = String.hiragana()
        XCTAssertTrue(hiragana.contains("\u{3041}"))
        XCTAssertTrue(hiragana.contains("\u{3096}"))
        XCTAssertTrue(hiragana.contains("な"))
        XCTAssertFalse(hiragana.contains("\u{3040}"))
        XCTAssertFalse(hiragana.contains("\u{3097}"))
    }
    
    func testKatakana() {
        let katakana = String.katakana()
        XCTAssertTrue(katakana.contains("\u{30A1}"))
        XCTAssertTrue(katakana.contains("\u{30F6}"))
        XCTAssertTrue(katakana.contains("ナ"))
        XCTAssertFalse(katakana.contains("\u{30A0}"))
        XCTAssertFalse(katakana.contains("\u{30F7}"))
    }
    
    func testBetween() {
        XCTAssertTrue("<a>foo</a>".between("<a>", "</a>") == "foo")
        XCTAssertTrue("<a><a>foo</a></a>".between("<a>", "</a>") == "<a>foo</a>")
        XCTAssertTrue("Some strings } are very {weird}, dont you think?".between("{", "}") == "weird")
        XCTAssertNil("<a>foo".between("<a>", "</a>"))
        XCTAssertNil("<a></a>".between("<a>", "</a>"))
        XCTAssertNil("<a>foo</a>".between("<a>", "<a>"))
    }
    
    func testMatches() {
        XCTAssertTrue("Swift Moji 2017".matches(regex: "^(.+)\\s(\\d{4})").count == 3)
        XCTAssertTrue("Swift Moji 2017".matches(regex: "^(.+)\\s(\\d{4})").first == "Swift Moji 2017")
        XCTAssertTrue("Swift Moji 2017".matches(regex: "^(.+)\\s(\\d{4})")[1] == "Swift Moji")
        XCTAssertTrue("Swift Moji 2017".matches(regex: "^(.+)\\s(\\d{4})").last == "2017")
        XCTAssertTrue("Swift Moji 2017".matches(regex: "\\d{4}").first == "2017")
        XCTAssertTrue("Swift Moji 2017".matches(regex: "^\\s").isEmpty)
        XCTAssertTrue("".matches(regex: "\\d{4}").isEmpty)
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
        XCTAssertTrue("abcDef_Ghi".snakecased() == "abc_def_ghi")
        XCTAssertTrue("abc99Def-Ghi".snakecased() == "abc99_def_ghi")
        XCTAssertTrue("abc99Def-Ghi99".snakecased() == "abc99_def_ghi99")
        XCTAssertTrue("ABCDEFG".snakecased() == "abcdefg")
        XCTAssertTrue("abc def".snakecased() == "abc_def")
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
    
    func testTruncated() {
        XCTAssertTrue("Returns the string that has trancated at the specified length".truncated(length: 10)
                      ==
                      "Returns th...")
        
        XCTAssertTrue("Returns the string that has trancated at the specified length".truncated(length: 100)
                      ==
                      "Returns the string that has trancated at the specified length")
        
        XCTAssertTrue("Returns the string that has trancated at the specified length".truncated(length: 10, trailing: "・・・")
                      ==
                      "Returns th・・・")
    }
    
    func testToColor() {
        XCTAssertTrue("black".toColor()! == UIColor.black)
        XCTAssertTrue("blue".toColor()! == UIColor.blue)
        XCTAssertTrue("brown".toColor()! == UIColor.brown)
        XCTAssertTrue("clear".toColor()! == UIColor.clear)
        XCTAssertTrue("cyan".toColor()! == UIColor.cyan)
        XCTAssertTrue("darkGray".toColor()! == UIColor.darkGray)
        XCTAssertTrue("darkText".toColor()! == UIColor.darkText)
        XCTAssertTrue("gray".toColor()! == UIColor.gray)
        XCTAssertTrue("green".toColor()! == UIColor.green)
        XCTAssertTrue("groupTableviewBackground".toColor()! == UIColor.groupTableViewBackground)
        XCTAssertTrue("lightgray".toColor()! == UIColor.lightGray)
        XCTAssertTrue("lightText".toColor()! == UIColor.lightText)
        XCTAssertTrue("magenta".toColor()! == UIColor.magenta)
        XCTAssertTrue("orange".toColor()! == UIColor.orange)
        XCTAssertTrue("purple".toColor()! == UIColor.purple)
        XCTAssertTrue("red".toColor()! == UIColor.red)
        XCTAssertTrue("white".toColor()! == UIColor.white)
        XCTAssertTrue("yellow".toColor()! == UIColor.yellow)
        XCTAssertTrue("pink".toColor()! == UIColor(red:1.00, green:0.75, blue:0.80, alpha:1.0))
        XCTAssertTrue("abc".toColor() == nil)
    }
    
    func testIndexInt() {
        XCTAssertTrue("test".indexInt(of: "t") == 0)
        XCTAssertTrue("test".indexInt(of: "es") == 1)
        XCTAssertTrue("test".indexInt(of: "test") == 0)
        XCTAssertTrue("test".indexInt(of: "z") == nil)
    }
    
    func testIsCapitalized() {
        XCTAssertTrue("A".isCapitalized())
        XCTAssertTrue("Abc".isCapitalized())
        XCTAssertTrue("Abc Abc".isCapitalized())
        
        XCTAssertFalse("abc".isCapitalized())
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
        XCTAssertTrue("\u{3041}".isHiragana())
        XCTAssertTrue("\u{3096}".isHiragana())
        XCTAssertTrue("あいうえお".isHiragana())
        XCTAssertFalse("\u{3040}".isHiragana())
        XCTAssertFalse("\u{3097}".isHiragana())
        XCTAssertFalse("".isHiragana())
    }
    
    func testIsKatakana() {
        XCTAssertTrue("アイウエオ".isKatakana())
        XCTAssertTrue("\u{30A1}".isKatakana())
        XCTAssertTrue("\u{30FA}".isKatakana())
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
                _ = "UserId".snakecased()
            }
        }
    }
    
    
    
}
