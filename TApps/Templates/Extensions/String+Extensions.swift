//
//  String+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 18/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension String {
    
    public var localized: String {
        let path = Bundle.main.path(forResource: TUserAccount.shared.language.officialCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: self, comment: self)
    }

    public func localized(arguments: [CVarArg]) -> String {
        return String(format: self.localized, arguments: arguments)
    }

    public subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
}


extension String {
    func formattedString(mask: String = "(XXX) XXX-XXXX") -> String {
        let number = self
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    /// Returns String value between argument characters
    public func subStringFrom(_ fromCharacter: Character, toCharacter: Character) -> String {
        var fromIndex = self.getIndex(fromCharacter)
        var toIndex = self.getIndex(toCharacter)
        if fromIndex == -1 && toIndex == -1 {
            return self
        }  else if fromIndex > toIndex {
            return self
        }
        fromIndex = fromIndex > -1 ? fromIndex : 0
        toIndex = toIndex > -1 ? toIndex : self.length
        return self[fromIndex+1 ..< toIndex]
    }
    
    /// Returns String value from argument index to end
    public func substringFromIndex(_ index: Int) -> String {
        return self[index..<self.length]
    }
    
    /// Returns String value from start to argument index
    public func substringToIndex(_ index: Int) -> String {
        return self[0..<index]
    }
    
    
    public mutating func placeholder(_ text: String) -> String{
        self = self.isEmpty ? text : self
        return self
    }
}

// search
extension String {
    
    /// Return index of argument character
    public func getIndex(_ character: Character) -> Int {
        var index = -1
        for ch in self {
            index += 1
            if ch == character {
                return index
            }
        }
        return -1
    }
    
    public static func binarySearch (_ str: String, searchCh: Character, start: Int, end: Int) -> Int {
        var mid = (start + end) / 2
        if str[mid] == searchCh {
            while (mid + 1 < str.count && str[mid + 1] == searchCh) {
                mid += 1
            }
            return mid
        } else if start == end {
            return -1
        } else if str[mid] < searchCh {
            return binarySearch(str, searchCh: searchCh, start: mid + 1, end: end)
        } else {
            return binarySearch(str, searchCh: searchCh, start: start, end: mid)
        }
    }
}

// remove
extension String {
    public mutating func removeFromRange(_ range: Range<Int>) {
        self.removeSubrange(index(startIndex, offsetBy: range.lowerBound) ..< index(endIndex, offsetBy: range.upperBound - length))
    }
}

//info
extension String {
    
    /// Return count of characters
    public var length: Int {
        get {
            return self.count
        }
    }
    
    public func compareToIgnoreCase(_ str: String) -> ComparisonResult {
        return self.lowercased().compare(str.lowercased())
    }
    
    public func containsIgnoreCase(_ str: String) -> Bool {
        return self.lowercased().contains(str.lowercased())
    }
    
    /// Return Bool value after checking for containing argument value
    public func contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    /// Return Bool value after checking for containing argument value by compare option
    public func contains(_ find: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: find, options: compareOption) != nil
    }
}

// convert
extension String {
    /// Converting Any Object to String
    public static func toStr(_ obj: Any) -> String
    {
        return "\(obj)"
    }
    
    /// Converting Data to String
    public static func toString(_ data: Data) ->String? {
        var buffer = [UInt8](repeating: 0x00, count: data.count)
        (data as NSData).getBytes(&buffer, length:data.count)
        let datastring = String(bytes:buffer, encoding:String.Encoding.utf8)
        return datastring
    }
    
    /// Returns optional value of type Data
    public func toData(_ encoding: String.Encoding) -> Data? {
        return self.data(using: encoding)
    }
    public var toDataUTF8Encoding: Data? {
        return toData(String.Encoding.utf8)
    }
    
    /// Converting to Int
    public var toInt: Int {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return 0
        }
    }
    public var toInt64: Int64 {
        let t = Int64(self)
        return t ?? 0
    }
    /// Converting to Double
    public var toDouble: Double {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return 0
        }
    }
    
    /// Converting to Float
    public var toFloat: Float {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return 0
        }
    }

    /// Converting to Decimal
    public var toDecimal: NSDecimalNumber {
        return  NSDecimalNumber(string: self, locale: Locale(identifier: "en-US"))
    }

    /// Converting to Dictionary
    public var toDictionary: Dictionary<String, AnyObject>? {
        do {
            let dic = try JSONSerialization.jsonObject(with: self.toDataUTF8Encoding!, options: JSONSerialization.ReadingOptions.allowFragments)
            return dic as? Dictionary
        } catch {
            logger.log(message: "error in parsing \(self) to dictionary: \(error)", type: .error)
        }
        return nil
    }
    
    /// Converting to NSArray
    public var toArray: NSArray? {
        do {
            let arr = try JSONSerialization.jsonObject(with: self.toDataUTF8Encoding!, options: JSONSerialization.ReadingOptions.allowFragments)
            return arr as? NSArray
        } catch {
            logger.log(message: "error in parsing \(self) to array: \(error)", type: .error)
        }
        return nil
    }
    
    ///
    public func toJsonArray<T>() -> Array<T> {
        do {
            let arr = try JSONSerialization.jsonObject(with: self.toDataUTF8Encoding!, options: JSONSerialization.ReadingOptions.allowFragments)
            return arr as! Array<T>
        } catch {
            logger.log(message: "error in parsing \(self) to array: \(error)", type: .error)
        }
        return Array<T>()
    }
}

//frame
extension String {
    public func size(_ font: UIFont) -> CGSize {
        let str: NSString = self as NSString
        return str.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    public func width(_ font: UIFont) -> CGFloat {
        return size(font).width
    }
    public func height(_ font: UIFont) -> CGFloat {
        return size(font).height
    }
}

//edit elements
extension String {
    public var capitalizeFirst: String {
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }
}

//other
extension String {
    /// Counts whitespace & new lines
    public func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        let characterSet = CharacterSet.whitespacesAndNewlines
        let newText = self.trimmingCharacters(in: characterSet)
        return newText.isEmpty
    }
    ///
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    public mutating func trimFromNilOptional() {
        let str = self
        if str.lowercased().hasPrefix("optional") {
            self = str.subStringFrom("(", toCharacter: ")")
        } else {
            self = str == "nil" ? "" : self
        }
    }
    public static func trimFromNilOptional(_ str: String) -> String {
        var s = str
        s.trimFromNilOptional()
        return s
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    /// Trims white space and new line characters
    public mutating func trim() {
        self = self.trim()
    }
}

//split
extension String {
    public func split(_ separator: Character) -> Array<String> {
        return self.split(separator: separator).map(String.init)
    }
    public func splitStr(_ separator: String) -> Array<String> {
        return self.components(separatedBy: separator)
    }
    
    var isValidEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
}
//lines
extension String {
    public func lines() -> Array<String> {
        return self.split("\n")
    }
    public func lineCount() -> Int {
        return self.lines().count
    }
    public func getLine(_ linePrefix: String) -> Int {
        let lines = self.lines()
        for (line, item) in lines.enumerated() {
            if item.hasPrefix(linePrefix) {
                return line
            }
        }
        return -1
    }
    public mutating func changeLine(_ line: Int, newLine: String) {
        var lines = self.lines()
        if line > -1 {
            if lines.count > line {
                lines[line] = newLine
                self = lines.joined(separator: "\n")
            }
        }
    }
    
    public mutating func changeLine(_ linePrefix: String, newLine: String) {
        let line = getLine(linePrefix)
        self.changeLine(line, newLine: newLine)
    }
    
}

//regex
//extension String {
//    public func matches(_ regex: Regex) -> Bool {
//        return regex.matches(self)
//    }
//    public func matches(_ pattern: String) -> Bool {
//        return self.matches(Regex(pattern))
//    }
//    
//    public func replaceAll(_ regex: Regex, replacement: String) -> String {
//        return regex.repplaceAll(self, replacement: replacement)
//    }
//    
//    public func replaceAll(_ pattern: String, replacement: String) -> String {
//        return self.replaceAll(Regex(pattern), replacement: replacement)
//    }
//}

//
extension String {
    public mutating func append(_ array: Array<Character>, offset: Int, length: Int) {
        for i in offset ..< length {
            self += String(array[i])
        }
    }
}

extension String {
    
    public func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    public func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    public func base64() -> String {
        if let data = self.data(using: String.Encoding.utf8) {
            return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        return ""
    }
}

extension String {
    /// Returns height of text with arg font and line height
    public func heightWithWidth(width: CGFloat, font: UIFont, lineHeight: CGFloat? = nil) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        var attributes: [NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
        if lineHeight != nil {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight!
            attributes[kCTParagraphStyleAttributeName as NSAttributedString.Key] = style
        }
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return boundingBox.height
    }

    /// Returns height of text with arg font
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
    
    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
                Array(Array(self)[$0..<min($0 + every, Array(self).count)])
            }.joined(separator: separator))
    }
    
    public func removeSpaces() -> String {
        return self.replacingOccurrences(of: "^\\s|\\s+|\\s$", with: "", options: .regularExpression)
    }
    
    /// ex: "{\"amount\":\"500\",\"clientid\":\"+9989xxxxxxxx\"}" to dictionary
    func convertToDictionary() -> [String: String]? {
        if let data = self.data(using: .utf8) {
            do {
                let objc = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                var result: [String: String] = [:]
                objc?.forEach({ (obj) in
                    result[obj.key] = "\(obj.value)"
                })
                
                return result
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

