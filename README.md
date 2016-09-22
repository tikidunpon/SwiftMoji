# SwiftMoji

[![CI Status](http://img.shields.io/travis/tikidunpon/SwiftMoji.svg?style=flat)](https://travis-ci.org/tikidunpon/SwiftMoji)
[![Version](https://img.shields.io/cocoapods/v/SwiftMoji.svg?style=flat)](http://cocoapods.org/pods/SwiftMoji)
[![License](https://img.shields.io/cocoapods/l/SwiftMoji.svg?style=flat)](http://cocoapods.org/pods/SwiftMoji)
[![Swift-3.0](https://img.shields.io/badge/Swift-3.0-blue.svg)]()

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Methods

**first()**
```swift
"abc".first() // "a"
```

**second()**
```swift
"abc".second() // "b"
```

**last()**
```swift
"abc".last() // "c"
```

**camelized()**
```swift
"abc_def".camelized() // "AbcDef"
```  

**snakecased()**
```swift
"UserId".snakecased() // "user_id"
```

**trimmed() trimmedLeft() trimmedRight()**
```swift
"   abcdef   ".trimmed()      // "abcdef"
"   abcdef   ".trimmedLeft()  // "abcdef   "
"   abcdef   ".trimmedRight() // "   abcdef"
```

**uppercasedFirst()**
```swift
"abc".uppercasedFirst() // "Abc"
```

**lowercasedFirst()**
```swift
"ABC".lowercasedFirst() // "aBC"
```

**isCapitalized()**
```swift
"Abc".isCapitalized() // "true"
"abc".isCapitalized() // "false"
```

**isUppercased()**
```swift
"ABC".isOnlyUppercased()   // "true"
"A_B_C".isOnlyUppercased() // "false"
```

**isLowercased()**
```swift
"abc".isOnlyLowercased()   // "true"
"a_b_c".isOnlyLowercased() // "false"
```

**isUpperCamelized()**
```swift
"UserId".isUpperCamelized() // "true"
"userId".isUpperCamelized() // "false"
```

**isLowerCamelized()**
```swift
"userId".isLowerCamelized() // "true"
"UserId".isLowerCamelized() // "false"
```

**isAlphabet()**
```swift
"abc".isAlphabet() // "true"
"123".isAlphabet() // "false"
"   ".isAlphabet() // "false"
```

**isNumeric()**
```swift
"-1.983388".isNumeric() // "true"
"abc".isNumeric()       // "false"
```

**isHiragana()**
```swift
"あいうえお".isHiragana() // "true"
"abc".isHiragana()      // "false"
```  

**isKatakana()**
```swift
"アイウエオ".isKatakana() // "true"
"abc".isKatakana()      // "false"
```

## Installation

SwiftMoji is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftMoji"
```

## Author

tikidunpon, https://twitter.com/tikidunpon

## License

SwiftMoji is available under the MIT license. See the LICENSE file for more info.
