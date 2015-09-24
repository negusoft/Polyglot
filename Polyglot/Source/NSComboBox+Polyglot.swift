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

import AppKit

@IBDesignable
public extension NSComboBox {

    /// Comma separated keys to set the corresponding items with the localized string.
    /// Note that each key is trimed to remove leading and trailing spaces.
    /// You may as well leave a key empty not to change that specific item.
    @IBInspectable
    var titleKeysCSV: String {
        get { return "" }
        set {
            let keys = newValue.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ","))

            var items = [AnyObject]()
            for index in 0..<self.numberOfItems {
                let item = localizedItemForKeys(keys, atIndex: index)
                items.append(item)
            }

            self.removeAllItems()
            self.addItemsWithObjectValues(items)
        }
    }

    private func localizedItemForKeys(keys: [String], atIndex index: Int) -> AnyObject {
        if index >= keys.count {
            return self.itemObjectValueAtIndex(index)
        }

        let spaceCharacterSet = NSCharacterSet(charactersInString: " ")
        let key = keys[index].stringByTrimmingCharactersInSet(spaceCharacterSet)
        let item = self.itemObjectValueAtIndex(index)
        if key.isEmpty {
            return item
        }
        if item is String {
            return NSLocalizedString(key, comment:key)
        }
        return item
    }
}
