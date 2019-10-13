# SwiftMoji

[![CI Status](http://img.shields.io/travis/tikidunpon/SwiftMoji.svg?style=flat)](https://travis-ci.org/tikidunpon/SwiftMoji)
[![Code Climate](https://codeclimate.com/github/tikidunpon/SwiftMoji/badges/gpa.svg)](https://codeclimate.com/github/tikidunpon/SwiftMoji)
[![codecov](https://codecov.io/gh/tikidunpon/SwiftMoji/branch/master/graph/badge.svg)](https://codecov.io/gh/tikidunpon/SwiftMoji)
[![Version](https://img.shields.io/cocoapods/v/SwiftMoji.svg?style=flat)](http://cocoapods.org/pods/SwiftMoji)
[![License](https://img.shields.io/cocoapods/l/SwiftMoji.svg?style=flat)](http://cocoapods.org/pods/SwiftMoji)
[![Swift-5.0](https://img.shields.io/badge/Swift-5.0-blue.svg)]()

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Methods

**between()**
```swift
"<a>foo</a>".between("<a>", "</a>") // "foo"
"<a><a>foo</a></a>".between("<a>", "</a>") // "<a>foo</a>"
"<a>foo".between("<a>", "</a>") // nil
"Some strings } are very {weird}, dont you think?".between("{", "}") // "weird"
"<a></a>".between("<a>", "</a>") // nil
"<a>foo</a>".between("<a>", "<a>") // nil
```

**matches()**
```swift
let matches = "Swift Moji 9876".matches(regex: "^(.+)\\s(\\d{4})")

// first is the entire capture
matches.first // "Swift Moji 9876"

// individual capture groups begin from [1]
matches[1] // "Swift Moji"
matches.last // "2017"
```

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

**hiragana()**
```swift
String.hiragana()　
//ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔゕゖ
```

**katakana()**
```swift
String.katakana()　
//ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶ
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
**truncated()**
```
"Returns the truncated string".truncated(length: 10)  // "Returns th..."
"Returns the truncated string".truncated(length: 10, trailing: "・・・")  // "Returns th・・・"
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
