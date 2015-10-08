**Polyglot** allows localizing the user interface straight from the Storyboard/XIB files in Interface Builder.

It provides extensions to common UI elements to set the localized text in Interface Builder. For instance, a UILabel will display a _"Text Key"_ property. When a value is set, Polyglot will call NSLocalizedString using the given value and set it to the label's text property.

## Why Polyglot?

There are already several ways to internationalize the UI:
- Traditionally, we would duplicate each **storyboard for every locale**. This makes the storyboards really hard to maintain.
- It is a common practice to define **outlets** for every UI element and set the text using **NSLocalizedString**. It adds unnecessary outlets and lots of boilerplate code.
- **_Base internationalization_** is a powerful tool to localize the UI, but let's face it, it is not the optimal solution. The generated _string files_ are hard to maintain and it is not developper friendly when making changes to the storyboard.

**Polyglot** doesn't try to replace these tools, but provide a complementary approach to the localization process. It is a clean and simple solution compared to creating outlets. It is also easy to maintain, while keeping control of the _strings file_.

## Requirements

- iOS 8.0+ / Mac OS X 10.9+
- Xcode 7.0+

## Setup

### CocoaPods

Make sure that you are using the lates [CocoaPods](http://cocoapods.org) version.

Then add Polyglot pod to your podfile. This is an example of a podfile for an iOS app:

```ruby
platform :ios, '8.0'
use_frameworks!

pod 'PolyglotLocalization'
```

Notice the _use_frameworks!_ line, it is important that you include it. Note also that the minimum platform versions needs to be respected as specified in the Requirements above.

Finally, don't forget to update your pods and open the generated _xcworkspace_ file:

```bash
$ pod install
```

### Other

There are other ways to include Polyglot in your project. Polyglot is a set of extensions written in Swift so you may as well copy the files to your project (not recommended), or add the project as a dependency... 

Just note that the project can not be included as a _static library_ since Interface Builder will not reconize the _inspectable_ properties in that case.

## Usage

### Basics

Once Polyglot is set up, open your Storyboard of XIB file. Select a UI element that displays some text (a UILabel for example), you will see a propery named "Text Key" in the propery inspector. Set the following value to the "Text Key" propery: _hello_wolrd_.

Now you will have to add the corresponding value to the _Localizable.strings_ file:
```
"hello_wolrd" = "Hello Wold";
```

You can now run the app and the label should display Hello World.

### Property naming

The properties that can be localized with Polyglot are named as the original properties followd by _key_:

- Text -> Text Key
- Title -> Title Key
- Placeholder -> Placeholder Key

This way, it is easy to recognize what properties will be localized in each case.

### CSV Properties

When a list of elements needs to be localized, the keys are specified in CSV (Comma Separated Values). This is the case for _segmented controls_ for example. The correponding properties are named accordingly: _Title KeysCSV_.

The list of keys is obtained by taking the comma separated values. The values are trimmed, so spaces next to the commas are ignored.

Then, each of the keys is used to localize the correponding element. For instance, the fist key will be used to localize the fist segment and so on. The following example would modify the titles of the fist three segments:
```
segment_one, segment_two, segment_three
```

In case there were more than three segments, the reset would not be modified. The same way, we can leave empty elements to ignore certain elements. The following example will only modify the first and the third segments' title:
```
segment_one, , segment_three
```

### UIButton

UIButton allows setting a title text for each state. In response to this, Polyglot provides one property for each state: default, highlighted, selected and disabled.

If we just need to asign one title for all states, we will only assign _Default Title Key_ and leave the rest empty.

## One More Thing...

If you like this library, make sure to share it!

## License

Polyglot is released under the MIT license. See LICENSE for details.
