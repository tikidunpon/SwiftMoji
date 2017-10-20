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
    static let AsciiUppercaseSet: Set<String> = Set("ABCDEFGHIJKLMNOPQRSTUVWXYZ".map{ String($0) })
    static let AsciiLowercaseSet: Set<String> = Set("abcdefghijklmnopqrstuvwxyz".map{ String($0) })
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
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            var matches = [String]()
            
            for result in results {
                for i in 0..<result.numberOfRanges {
                    let range = Range.init(result.range(at: i), in: self)
                    matches.append(String(self[range!]))
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
    
    /// Returns the second element of `self`, or `empty string` if `self` is empty
    func second() -> String {
        guard !isEmpty, count >= 2 else { return "" }
        return String(self[index(after: startIndex)])
    }
    
    /// Returns the last element of `self`, or `empty string` if `self` is empty
    func last() -> String {
        guard !isEmpty else { return self }
        return String(self[index(before: endIndex)])
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
          return String(self[range.lowerBound...])
        }
        return self
    }
    
    /// Returns string that has trimmed whitespace and newline that is on the right side of contents
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted,
                                        options: .backwards) {
          return String(self[..<range.upperBound])
        }
        return self
    }
    
    /// Returns the string that is uppercased the first element
    /// or empty string if `self` is empty
    func uppercasedFirst() -> String {
        return first().uppercased() + String(dropFirst())
    }

    /// Returns the string that is lowercased the first element
    /// or empty string if `self` is empty
    func lowercasedFirst() -> String {
        return first().lowercased() + String(dropFirst())
    }
  
    /// Remove redundant white space
    func removeRedundantWhitespace() -> String {
        let a = components(separatedBy: CharacterSet.whitespacesAndNewlines).filter{ !$0.isEmpty }
        return a.joined(separator: " ")
    }
  
    /// Returns the string that has truncated at the specified length
    func truncated(length: Int, trailing: String = "...") -> String {
        if count > length {
            return String(prefix(length)) + trailing
        } else {
            return self
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
            return count == self.count
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
            return count == distance(from: range.lowerBound, to: range.upperBound)
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
    
    /// Returns similarity of two words.
    static func similarity(_ lhs: String, _ rhs: String) -> Double {
        if lhs.count == 1 || rhs.count == 1 || lhs.isEmpty || rhs.isEmpty {
            return lhs == rhs ? 1.0 : 0
        }
        
        let s1 = bigramSet(lhs)
        let s2 = bigramSet(rhs)
        let s3 = s1.intersection(s2)
        
        return Double(s3.count) / Double(s1.count)
    }
    
    /// Returns `self` and `to` are similar or not.
    func isSimilar(to: String, threshold: Double = 0.6) -> Bool {
        guard threshold > 0 else {
            assertionFailure("threshold must be 0.1 or more")
            return false
        }
        if self.count == 1 || to.count == 1 || self.isEmpty || to.isEmpty {
            return self == to
        }
        
        let s1 = String.bigramSet(self)
        let s2 = String.bigramSet(to)
        let s3 = s1.intersection(s2)
        return (Double(s3.count) / Double(s1.count)) >= threshold
    }
    
    private static func bigramSet(_ s: String) -> Set<String> {
        return Set(String.charNgram(input: s, n: 2))
    }
    
    /// Returns ngram array from specified input
    static func charNgram(input: String, n: Int) -> [String] {
        let words = input.components(separatedBy: " ")
            .map{ $0.trimmingCharacters(in: CharacterSet(charactersIn: ",.")) }
            .joined().characters.map{ String($0) }
        return words.enumerated().flatMap{ (i, _) in
            if words.indices.contains(i + n - 1) {
                return words[i..<i+n].reduce("", +)
            } else {
                return nil
            }
        }
    }
    
    /// `true` if `self` is only alphabet.
    fileprivate func isOnlyComposed(characterSet set: Set<String>) -> Bool {
        guard !isEmpty else { return false }
        
        for c in self {
            if !set.contains(String(c)) {
                return false
            }
        }
        return true
    }
  
}
