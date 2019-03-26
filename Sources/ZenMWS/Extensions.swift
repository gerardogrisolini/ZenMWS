//
//  Extensions.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 21/04/18.
//

import Foundation

extension Int {
    
    static func now() -> Int {
        return Int(Date.timeIntervalSinceReferenceDate)
    }
    
    func formatDateShort() -> String {
        return formatDate(format: "yyyy-MM-dd")
    }
    
    func formatDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> String {
        if self == 0 { return "" }
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: date)
    }
}

extension String {
    // returning encoded url string
    func encodeURIComponent() -> String? {
        let unreserved = "-_.!~*'()" //"-._~/?"
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: unreserved)
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
}

extension Formatter {
    // returning iso dateformater
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"//"yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension Date {
    // returning iso date
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}
