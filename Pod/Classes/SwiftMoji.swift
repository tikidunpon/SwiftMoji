//
//  SwiftMoji.swift
//  SwiftMoji
//
//  Created by koichi tanaka on 2016/04/02.
//  Copyright © 2016年 koichi tanaka. All rights reserved.
//

import Foundation

private class MojiConstant {
    static let ASCII_UPPERCASE_SET = Set(["A", "B", "C", "D", "E", "F", "G","H", "I", "J", "K", "L", "M", "N","O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"])
    
    static let ASCII_LOWERCASE_SET = Set(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"])
    
    static let ASCII_ALPHABET_SET = ASCII_UPPERCASE_SET.union(ASCII_LOWERCASE_SET)
    
    static let NUMBER_FORMATTER = NSNumberFormatter()
}

public extension String {
    
    private var ASCII_LOWERCASE_SET: Set<String> {
        return MojiConstant.ASCII_LOWERCASE_SET
    }
    
    private var ASCII_UPPERCASE_SET: Set<String> {
        return MojiConstant.ASCII_UPPERCASE_SET
    }
    
    private var ASCII_ALPHABET_SET: Set<String> {
        return MojiConstant.ASCII_ALPHABET_SET
    }
    
    private var NUMBER_FORMATTER: NSNumberFormatter {
        return MojiConstant.NUMBER_FORMATTER
    }
    
    //MARK: Search
    
    /// Returns the first element of `self`, or `empty string` if `self` is empty.
    func first() -> String {
        guard !self.isEmpty else { return self }
        
        return String(self[self.startIndex])
    }
    
    /// Returns the last element of `self`, or `empty string` if `self` is empty
    func last() -> String {
        guard !self.isEmpty else { return self }
        
        return String(self[self.endIndex.predecessor()])
    }
    
    //MARK: Change
    /// Returns upper-camelized String
    func camelized() -> String {
        guard !self.isEmpty else { return self }
        
        return self.stringByReplacingOccurrencesOfString("_", withString: " ")
                   .stringByReplacingOccurrencesOfString("-", withString: " ")
                   .capitalizedString
                   .stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    /// Returns snakecased string from camelized string.
    func snakecased() -> String {
        guard !self.isEmpty else { return self }
        
        let singleUnderscored = self.stringByReplacingOccurrencesOfString("-", withString: "_")
                                    .stringByReplacingOccurrencesOfString(" ", withString: "_")
                                    .stringByReplacingOccurrencesOfString("_+",withString: "_",
                                                                               options: .RegularExpressionSearch,
                                                                               range: nil)
        if singleUnderscored.isUppercased() {
            return singleUnderscored.lowercaseString
        }
        
        let pattern     = "([a-z0-9])([A-Z])"
        let replacement = "$1_$2"
        return singleUnderscored.stringByReplacingOccurrencesOfString(pattern,
                                                                      withString: replacement,
                                                                      options: .RegularExpressionSearch,
                                                                      range: nil).lowercaseString
    }
    
    /// Returns string that has trimmed whitespace and newline
    func trimmed() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the left side of contents
    func trimmedLeft() -> String {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet) {
            return self[range.startIndex..<endIndex]
        }
        return self
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the right side of contents
    func trimmedRight() -> String {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet, options: NSStringCompareOptions.BackwardsSearch) {
            return self[startIndex..<range.endIndex]
        }
        return self
    }
    
    /// Returns the string that is uppercased the first element
    /// or empty string if `self` is empty
    func uppercasedFirst() -> String {
        return self.first().uppercaseString + String(self.characters.dropFirst())
    }

    /// Returns the string that is lowercased the first element
    /// or empty string if `self` is empty
    func lowercasedFirst() -> String {
        return self.first().lowercaseString + String(self.characters.dropFirst())
    }
    
    //MARK: Check
    /// `true` if `self` is capitalized.
    func isCapitalized() -> Bool {
        guard !self.isEmpty else { return false }
        
        return self == self.capitalizedString
    }
    
    /// `true` if `self` is uppercased.
    func isUppercased() -> Bool {
        guard !self.isEmpty else { return false }
        
        let rangeOfLower = self.rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet())
        let rangeOfUpper = self.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet())
        if rangeOfLower == nil && rangeOfUpper != nil {
            return true
        }
        return false
    }
    
    /// `true` if `self` is only uppercased.
    func isOnlyUppercased() -> Bool {
        guard !self.isEmpty else { return false }
        
        return self.isOnlyComposed(characterSet: MojiConstant.ASCII_UPPERCASE_SET)
    }
    
    /// `true` if `self` is lowercased.
    func isLowercased() -> Bool {
        guard !self.isEmpty else { return false }
        
        let rangeOfLower = self.rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet())
        let rangeOfUpper = self.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet())
        if rangeOfLower != nil && rangeOfUpper == nil {
            return true
        }
        
        return false
    }
    
    /// `true` if `self` is only lowercased.
    func isOnlyLowercased() -> Bool {
        guard !self.isEmpty else { return false }
        
        return self.isOnlyComposed(characterSet: MojiConstant.ASCII_LOWERCASE_SET)
    }
    
    /// `true` if `self` is upper-camelized.
    func isUpperCamelized() -> Bool {
        guard !self.isEmpty else { return false }
        
        if let range = self.rangeOfString("^[A-Z]+[0-9]*[A-Za-z]*[a-z]+[\\w\\d]*", options: .RegularExpressionSearch, range: nil, locale: nil) {
            return range.count == self.characters.count
        } else {
            return false
        }
    }
    
    /// `true` if `self` is lower-camelized.
    func isLowerCamelized() -> Bool {
        guard !self.isEmpty else { return false }
        
        if let range = self.rangeOfString("^[a-z]+[0-9]*[A-Za-z]*[a-z]+[\\w\\d]*", options: .RegularExpressionSearch, range: nil, locale: nil) {
            return range.count == self.characters.count
        } else {
            return false
        }
    }
    
    /// `true` if `self` is only composed alphabet.
    func isAlphabet() -> Bool {
        return self.isOnlyComposed(characterSet: ASCII_ALPHABET_SET)
    }
    
    /// `true` if `self` is only composed numeric.
    func isNumeric() -> Bool {
        if let _ = NUMBER_FORMATTER.numberFromString(self) {
            return true
        }
        return false
    }
    
    /// `true` if `self` is only alphabet.
    private func isOnlyComposed(characterSet set :Set<String>) -> Bool {
        guard !self.isEmpty else { return false }
        
        for c in self.characters {
            if !set.contains(String(c)) {
                return false
            }
        }
        return true
    }
    
}
