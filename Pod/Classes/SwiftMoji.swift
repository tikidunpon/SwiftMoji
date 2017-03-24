//
//  SwiftMoji.swift
//  SwiftMoji
//
//  Created by koichi tanaka on 2016/04/02.
//  Copyright © 2016年 koichi tanaka. All rights reserved.
//

import Foundation
import UIKit

//MARK: Constant
private extension String {
    static let AsciiUppercaseSet: Set<String> = Set(["A", "B", "C", "D", "E", "F", "G","H", "I", "J", "K", "L", "M", "N","O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"])
    
    static let AsciiLowercaseSet: Set<String> = Set(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"])
    
    static let AsciiAlphabetSet: Set<String> = AsciiUppercaseSet.union(AsciiLowercaseSet)
    
    static let DefaultNumberFormatter = NumberFormatter()
}

//MARK: SwiftMoji
public extension String {
    
    //MARK: Search
    
    ///  Finds the string between two bookend strings if it can be found.
    ///
    ///  - parameter left:  The left bookend
    ///  - parameter right: The right bookend
    ///
    ///  - returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(_ left: String, _ right: String) -> String? {
        guard let leftRange = range(of: left),
              let rightRange = range(of: right, options: .backwards),
              left != right && leftRange.upperBound != rightRange.lowerBound
            else { return nil }
        
        return self[leftRange.upperBound..<rightRange.lowerBound]
    }
    
    /// Returns the first element of `self`, or `empty string` if `self` is empty.
    func first() -> String {
        guard !self.isEmpty else { return self }
        return String(self[self.startIndex])
    }
    
    func second() -> String {
        guard !self.isEmpty else { return self }
        
        let secondIndex = self.index(after: self.startIndex)
        let secondIndexInt = self.distance(from: self.startIndex,
                                           to: secondIndex)
        
        guard self.characters.count > secondIndexInt else { return "" }

        return String(self[secondIndex])
    }
    
    /// Returns the last element of `self`, or `empty string` if `self` is empty
    func last() -> String {
        guard !self.isEmpty else { return self }
        let beforeEndIndex = self.index(before: self.endIndex)
        return String(self[beforeEndIndex])
    }
    
    //MARK: Change
    /// Returns upper-camelized String
    func camelized() -> String {
        guard !self.isEmpty else { return self }
        
        return self.replacingOccurrences(of: "_", with: " ")
                   .replacingOccurrences(of: "-", with: " ")
                   .capitalized
                   .replacingOccurrences(of: " ", with: "")
    }
    
    
    /// Returns index as Int?
    ///
    /// - Parameter character: a search target character
    /// - Returns: searched index or nil
    func indexInt(of: String) -> Int? {
        if let r = self.range(of: of) {
            return self.distance(from: self.startIndex, to: r.lowerBound)
        }
        return nil
    }
    
    /// Returns snakecased string from camelized string.
    func snakecased() -> String {
        guard !self.isEmpty else { return self }

        let singleUnderscored = self.replacingOccurrences(of: "-", with: "_")
                                    .replacingOccurrences(of: " ", with: "_")
                                    .replacingOccurrences(of: "_+",with: "_",
                                                        options: .regularExpression,
                                                        range: nil)
        if singleUnderscored.isUppercased() {
            return singleUnderscored.lowercased()
        }
        
        let pattern     = "([a-z0-9])([A-Z])"
        let replacement = "$1_$2"
        return singleUnderscored.replacingOccurrences(of: pattern,
                                                      with: replacement,
                                                      options: .regularExpression,
                                                      range: nil).lowercased()
    }
    
    /// Returns string that has trimmed whitespace and newline
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the left side of contents
    func trimmedLeft() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted) {
            return self[range.lowerBound..<endIndex]
        }
        return self
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the right side of contents
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted,
                                        options: .backwards) {
            return self[startIndex..<range.upperBound]
        }
        return self
    }
    
    /// Returns the string that is uppercased the first element
    /// or empty string if `self` is empty
    func uppercasedFirst() -> String {
        return self.first().uppercased() + String(self.characters.dropFirst())
    }

    /// Returns the string that is lowercased the first element
    /// or empty string if `self` is empty
    func lowercasedFirst() -> String {
        return self.first().lowercased() + String(self.characters.dropFirst())
    }
    
    /// The wapper of dropFirst
    func dropFirst() -> String {
        return String(self.characters.dropFirst())
    }
    
    /// The wapper of dropFirst(n: Int)
    func dropFirst(_ n: Int) -> String {
        return String(self.characters.dropFirst(n))
    }
    
    /// The wapper of dropLast
    func dropLast() -> String {
        return String(self.characters.dropLast())
    }
    
    /// The wapper of dropLast(n: Int)
    func dropLast(_ n: Int) -> String {
        return String(self.characters.dropLast(n))
    }
  
    /// Remove redundant white space
    func removeRedundantWhitespace() -> String {
        let a = components(separatedBy: CharacterSet.whitespacesAndNewlines).filter{ !$0.isEmpty }
        return a.joined(separator: " ")
    }
  
    /// Returns the string that has truncated at the specified length
    func truncated(length: Int, trailing: String = "...") -> String {
        if self.characters.count > length {
            return self.substring(to: index(startIndex, offsetBy: length)) + trailing
        } else {
            return self
        }
    }
    
    /// Returns the color if string is color name
    func toColor() -> UIColor? {
        switch self.lowercased() {
        case "black":
            return UIColor.black
        case "blue":
            return UIColor.blue
        case "brown":
            return UIColor.brown
        case "clear":
            return UIColor.clear
        case "cyan":
            return UIColor.cyan
        case "darkgray":
            return UIColor.darkGray
        case "darktext":
            return UIColor.darkText
        case "gray":
            return UIColor.gray
        case "green":
            return UIColor.green
        case "grouptableviewbackground":
            return UIColor.groupTableViewBackground
        case "lightgray":
            return UIColor.lightGray
        case "lighttext":
            return UIColor.lightText
        case "magenta":
            return UIColor.magenta
        case "orange":
            return UIColor.orange
        case "purple":
            return UIColor.purple
        case "red":
            return UIColor.red
        case "white":
            return UIColor.white
        case "yellow":
            return UIColor.yellow
        case "pink":
            return UIColor(red:1.00, green:0.75, blue:0.80, alpha:1.0)
        default:
            return nil
        }
    }
  
    //MARK: Check
    /// `true` if `self` is capitalized.
    func isCapitalized() -> Bool {
        guard !self.isEmpty else { return false }
        
        return self == self.capitalized
    }
    
    /// `true` if `self` is uppercased.
    func isUppercased() -> Bool {
        guard !self.isEmpty else { return false }
        
        return self.isOnlyComposed(characterSet: String.AsciiUppercaseSet)
    }
    
    /// `true` if `self` is lowercased.
    func isLowercased() -> Bool {
        guard !self.isEmpty else { return false }
        
        return self.isOnlyComposed(characterSet: String.AsciiLowercaseSet)
    }
    
    /// `true` if `self` is upper-camelized.
    func isUpperCamelized() -> Bool {
        guard !self.isEmpty else { return false }
        
        if let range = self.range(of: "^[A-Z]+[0-9]*[A-Za-z]*[a-z]+[\\w\\d]*",
                                  options: .regularExpression,
                                  range: nil, locale: nil) {
            let count = self.distance(from: range.lowerBound, to: range.upperBound)
            return count == self.characters.count
        } else {
            return false
        }
    }
    
    /// `true` if `self` is lower-camelized.
    func isLowerCamelized() -> Bool {
        guard !self.isEmpty else { return false }
        
        if let range = self.range(of: "^[a-z]+[0-9]*[A-Za-z]*[a-z]+[\\w\\d]*",
                                  options: .regularExpression,
                                  range: nil, locale: nil) {
            let count = self.distance(from: range.lowerBound, to: range.upperBound)
            return count == self.characters.count
        } else {
            return false
        }
    }
    
    /// `true` if `self` is only composed alphabet.
    func isAlphabet() -> Bool {
        return self.isOnlyComposed(characterSet: String.AsciiAlphabetSet)
    }
    
    /// `true` if `self` is only composed numeric.
    func isNumeric() -> Bool {
        if let _ = String.DefaultNumberFormatter.number(from: self) {
            return true
        }
        return false
    }
    
    /// `true` if `self` is only composed Japanese Hiragana
    /// if you'd like to get more details, see http://unicode.org/charts/PDF/U3040.pdf
    func isHiragana() -> Bool {
        guard !self.isEmpty else { return false }
        
        for unicodeScalar in self.unicodeScalars {
            if !(unicodeScalar.value >= 0x3041 && unicodeScalar.value <= 0x3096) {
                return false
            }
        }
        return true
    }
    
    /// `true` if `self` is only composed Japanese Katakana
    /// if you'd like to get more details, see http://unicode.org/charts/PDF/U30A0.pdf
    func isKatakana() -> Bool {
        guard !self.isEmpty else { return false }
        
        for unicodeScalar in self.unicodeScalars {
            if !(unicodeScalar.value >= 0x30A1 && unicodeScalar.value <= 0x30FA) {
                return false
            }
        }
        return true
    }
    
    /// `true` if `self` is only alphabet.
    fileprivate func isOnlyComposed(characterSet set :Set<String>) -> Bool {
        guard !self.isEmpty else { return false }
        
        for c in self.characters {
            if !set.contains(String(c)) {
                return false
            }
        }
        return true
    }
    
}
