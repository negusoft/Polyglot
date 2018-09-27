//
// Copyright (c) 2015 NEGU Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

/** Represents a class that can map localization keys to a strings. */
public protocol Localizer {
    func localizeString(_ key: String) -> String
}

/** Class to expose the Polyglot configuration. */
public class Polyglot {

    private static let tableNameDelimiters = (start: Character("["), end: "].")

    public static var localizer: Localizer = TabledLocalizer()

    static func localizedString(_ key: String) -> String {
        return localizer.localizeString(key)
    }
}

/** Default localizer. Parses the "[TABLE]KEY" to define the table and the translation key. */
public class TabledLocalizer : Localizer {
    
    public typealias LocalizeFunc = (String, String?) -> String

    private static let tableNameDelimiters = (start: Character("["), end: "].")
    public static var defaultLocalizer: LocalizeFunc {
        return { key, tableName in
            return NSLocalizedString(key, tableName: tableName, comment: key)
        }
    }

    private let localizeFunc: LocalizeFunc

    public init(_ localizeFunc: @escaping LocalizeFunc = defaultLocalizer) {
        self.localizeFunc = localizeFunc
    }

    public func localizeString(_ key: String) -> String {
        // If the key conforms to the "[TABLE]KEY" format -> use table based localization
        if let open = key.first, open == TabledLocalizer.tableNameDelimiters.start, let close = key.range(of: TabledLocalizer.tableNameDelimiters.end) {
            return localizeFunc(
                String(key[close.upperBound..<key.endIndex]),
                String(key[key.index(key.startIndex, offsetBy: 1)..<close.lowerBound])
            )
        }

        return localizeFunc(key, nil)
    }
}
