//
//  SwiftMoji.swift
//  SwiftMoji
//
//  Created by koichi tanaka on 2016/04/02.
//  Copyright © 2016年 koichi tanaka. All rights reserved.
//

import Foundation
import UIKit

// MARK: Constant
private extension String {
    static let AsciiUppercaseSet: Set<String> = Set("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters.map{String($0)})
    static let AsciiLowercaseSet: Set<String> = Set("abcdefghijklmnopqrstuvwxyz".characters.map{String($0)})
    static let AsciiAlphabetSet: Set<String> = AsciiUppercaseSet.union(AsciiLowercaseSet)
    static let DefaultNumberFormatter = NumberFormatter()
}

// MARK: SwiftMoji
public extension String {
    
    // MARK: Get
    
    /// Returns Japanese Hiragana as String see http://unicode.org/charts/PDF/U3040.pdf
    ///
    /// - Returns: The string of Hiragana
    static func hiragana() -> String {
        var str: String = ""
        let unicodes = [Int](0x3041...0x3096)
        unicodes.forEach { (unicode: Int) in
            str.append(Character(UnicodeScalar(unicode)!))
        }
        return str
    }
    
    /// Returns Japanese Katakana as String see http://unicode.org/charts/PDF/U3040.pdf
    ///
    /// - Returns: The string of Katakana
    static func katakana() -> String {
        var str: String = ""
        let unicodes = [Int](0x30A1...0x30F6)
        unicodes.forEach { (unicode: Int) in
            str.append(Character(UnicodeScalar(unicode)!))
        }
        return str
    }
    
    /// Finds the string between two bookend strings if it can be found.
    ///
    /// - Parameters:
    ///   - lhs: The left bookend
    ///   - rhs: The left bookend
    /// - Returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(_ lhs: String, _ rhs: String) -> String? {
        guard let leftRange = range(of: lhs),
              let rightRange = range(of: rhs, options: .backwards),
              lhs != rhs && leftRange.upperBound != rightRange.lowerBound
            else { return nil }
        
      return String(self[leftRange.upperBound..<rightRange.lowerBound])
    }
    
    /// Returns matched strings for a given regular expression.
    ///
    /// - Parameters:
    ///   - regex: regular expression
    /// - Returns: matched strings, The first result[0] is the entire capture, and then individual capture groups begin from [1].
    func matches(regex: String!) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            var matches = [String]()
            for result in results {
                for i in 0..<result.numberOfRanges {
                  matches.append(nsString.substring(with: result.range(at: i) ))
                }
            }
            return matches
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Returns the first element of `self`, or `empty string` if `self` is empty.
    func first() -> String {
        guard !isEmpty else { return self }
        return String(self[startIndex])
    }
    
    func second() -> String {
        guard !isEmpty else { return self }

        let secondIndex = index(after: startIndex)
        let secondIndexInt = distance(from: startIndex,
                                           to: secondIndex)
        
        guard characters.count > secondIndexInt else { return "" }

        return String(self[secondIndex])
    }
    
    /// Returns the last element of `self`, or `empty string` if `self` is empty
    func last() -> String {
        guard !isEmpty else { return self }
        let beforeEndIndex = index(before: endIndex)
        return String(self[beforeEndIndex])
    }
    
    // MARK: Change
    /// Returns upper-camelized String
    func camelized() -> String {
        guard !isEmpty else { return self }
        
        return replacingOccurrences(of: "_", with: " ")
              .replacingOccurrences(of: "-", with: " ")
              .capitalized
              .replacingOccurrences(of: " ", with: "")
    }
    
    
    /// Returns index as Int?
    ///
    /// - Parameter character: a search target character
    /// - Returns: searched index or nil
    func indexInt(of: String) -> Int? {
        if let r = range(of: of) {
            return distance(from: startIndex, to: r.lowerBound)
        }
        return nil
    }
    
    /// Returns snakecased string from camelized string.
    func snakecased() -> String {
        guard !isEmpty else { return self }

        let singleUnderscored = replacingOccurrences(of: "-", with: "_")
                               .replacingOccurrences(of: " ", with: "_")
                               .replacingOccurrences(of: "_+", with: "_",
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
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the left side of contents
    func trimmedLeft() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted) {
          return String(self[range.lowerBound..<endIndex])
        }
        return self
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the right side of contents
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted,
                                        options: .backwards) {
          return String(self[startIndex..<range.upperBound])
        }
        return self
    }
    
    /// Returns the string that is uppercased the first element
    /// or empty string if `self` is empty
    func uppercasedFirst() -> String {
        return first().uppercased() + String(characters.dropFirst())
    }

    /// Returns the string that is lowercased the first element
    /// or empty string if `self` is empty
    func lowercasedFirst() -> String {
        return first().lowercased() + String(characters.dropFirst())
    }
    
    /// The wrapper of dropFirst
    func dropFirst() -> String {
        return String(characters.dropFirst())
    }
    
    /// The wrapper of dropFirst(n: Int)
    func dropFirst(_ n: Int) -> String {
        return String(characters.dropFirst(n))
    }
    
    /// The wrapper of dropLast
    func dropLast() -> String {
        return String(characters.dropLast())
    }
    
    /// The wrapper of dropLast(n: Int)
    func dropLast(_ n: Int) -> String {
        return String(characters.dropLast(n))
    }
  
    /// Remove redundant white space
    func removeRedundantWhitespace() -> String {
        let a = components(separatedBy: CharacterSet.whitespacesAndNewlines).filter{ !$0.isEmpty }
        return a.joined(separator: " ")
    }
  
    /// Returns the string that has truncated at the specified length
    func truncated(length: Int, trailing: String = "...") -> String {
        if characters.count > length {
            return String(self[..<index(startIndex, offsetBy: length)]) + trailing
        } else {
            return self
        }
    }
    
    /// Returns the color if string is color name
    func toColor() -> UIColor? {
        switch lowercased() {
        case "black": return UIColor.black
        case "blue": return UIColor.blue
        case "brown": return UIColor.brown
        case "clear": return UIColor.clear
        case "cyan": return UIColor.cyan
        case "darkgray": return UIColor.darkGray
        case "darktext": return UIColor.darkText
        case "gray": return UIColor.gray
        case "green": return UIColor.green
        case "grouptableviewbackground": return UIColor.groupTableViewBackground
        case "lightgray": return UIColor.lightGray
        case "lighttext": return UIColor.lightText
        case "magenta": return UIColor.magenta
        case "orange": return UIColor.orange
        case "purple": return UIColor.purple
        case "red": return UIColor.red
        case "white": return UIColor.white
        case "yellow": return UIColor.yellow
        case "pink": return UIColor(red:1.00, green:0.75, blue:0.80, alpha:1.0)
        default: return nil
        }
    }
  
    // MARK: Check
    /// `true` if `self` is capitalized.
    func isCapitalized() -> Bool {
        guard !isEmpty else { return false }
        
        return self == capitalized
    }
    
    /// `true` if `self` is uppercased.
    func isUppercased() -> Bool {
        guard !isEmpty else { return false }
        
        return isOnlyComposed(characterSet: String.AsciiUppercaseSet)
    }
    
    /// `true` if `self` is lowercased.
    func isLowercased() -> Bool {
        guard !isEmpty else { return false }
        
        return isOnlyComposed(characterSet: String.AsciiLowercaseSet)
    }
    
    /// `true` if `self` is upper-camelized.
    func isUpperCamelized() -> Bool {
        guard !isEmpty else { return false }
        
        if let range = range(of: "^[A-Z]+[0-9]*[A-Za-z]*[a-z]+[\\w\\d]*",
                             options: .regularExpression,
                             range: nil, locale: nil) {
            let count = distance(from: range.lowerBound, to: range.upperBound)
            return count == characters.count
        } else {
            return false
        }
    }
    
    /// `true` if `self` is lower-camelized.
    func isLowerCamelized() -> Bool {
        guard !isEmpty else { return false }
        
        if let range = range(of: "^[a-z]+[0-9]*[A-Za-z]*[a-z]+[\\w\\d]*",
                             options: .regularExpression,
                             range: nil, locale: nil) {
            let count = distance(from: range.lowerBound, to: range.upperBound)
            return count == characters.count
        } else {
            return false
        }
    }
    
    /// `true` if `self` is only composed alphabet.
    func isAlphabet() -> Bool {
        return isOnlyComposed(characterSet: String.AsciiAlphabetSet)
    }
    
    /// `true` if `self` is only composed numeric.
    func isNumeric() -> Bool {
        if String.DefaultNumberFormatter.number(from: self) != nil {
            return true
        }
        return false
    }
    
    /// `true` if `self` is only composed Japanese Hiragana
    /// if you'd like to get more details, see http://unicode.org/charts/PDF/U3040.pdf
    func isHiragana() -> Bool {
        guard !isEmpty else { return false }
        
        for unicodeScalar in unicodeScalars {
            if !(unicodeScalar.value >= 0x3041 && unicodeScalar.value <= 0x3096) {
                return false
            }
        }
        return true
    }
    
    /// `true` if `self` is only composed Japanese Katakana
    /// if you'd like to get more details, see http://unicode.org/charts/PDF/U30A0.pdf
    func isKatakana() -> Bool {
        guard !isEmpty else { return false }
        
        for unicodeScalar in unicodeScalars {
            if !(unicodeScalar.value >= 0x30A1 && unicodeScalar.value <= 0x30FA) {
                return false
            }
        }
        return true
    }
    
    /// `true` if `self` is only alphabet.
    fileprivate func isOnlyComposed(characterSet set: Set<String>) -> Bool {
        guard !isEmpty else { return false }
        
        for c in characters {
            if !set.contains(String(c)) {
                return false
            }
        }
        return true
    }
    
}
