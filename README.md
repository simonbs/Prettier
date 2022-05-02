# Prettier

A wrapper for the [Prettier](https://prettier.io) code formatter written in Swift.
The package runs the code formatter in Apple's [JavaScriptCore](https://developer.apple.com/documentation/javascriptcore).
All the necessary JavaScript files are bundled with this package.

### Can this package be used in production?

Probably. The package uses stable versions of all dependencies and I intend to use it in one of my upcoming projects. Use it at your own risk though.

## Installation

Prettier is distributed using the [Swift Package Manager](https://www.swift.org/package-manager/). Install it in your project by adding it as a dependency in your Package.swift manifest or through "Package Dependencies" in your project settings.

```swift
let package = Package(
    dependencies: [
        .package(url: "git@github.com:simonbs/Prettier.git", from: "0.1.0")
    ]
)
```

## Usage

To get started with Prettier you must first import the module.

```swift
import Prettier
```

Now you can create an instance of PrettierFormatter.

```swift
let formatter = PrettierFormatter(language: .javaScript)
```

We're passing a language when creating an instance of PrettierFormatter. This is the programming language of the code to format.
The package contains all the languages officially supported by the Prettier code formatter which can be built to run in JavaScriptCore.
See the list of supported languages below.

After creating an instance of PrettierFormatter, you must prepare the formatter before formatting code.

```swift
formatter.prepare()
```

This prepares the instance by loading the bundled JavaScript files from disk and evaluating them in JavaScriptCore.
It is recommended to do this as early as possible so you're ready to format the code later.

With the PrettierFormatter instance prepared you can start formatting code.

```swift
// 💩 This is some poorly formatted JavaScript that we'll format.
let script = """
if(hello=="world"){
return"Hello world"
}
"""
// Earlier we have created and prepared our instance of Prettier. We're ready to format the JavaScript code.
let result = formatter.format(script)
switch result {
case .success(let formattedCode):
    print(formattedCode)
    // ✨ Here's our formatted code. Looks great!
    // if (hello == "world") {
    //   return "Hello world";
    // }
case .failure(let error):
    // Perform proper error handling.
    print(error)
}
```

It's possible to format only a specific range in the input string by calling `-format(:limitedTo:)`.

```swift
let result = formatter.format(script, limitedTo: 20 ... 39)
switch result {
case .success(let formattedCode):
    break
case .failure(let error):
    // Perform proper error handling.
    print(error)
}
```

You can also specify a location to be translated from the unformatted code to the formatted code.
This is useful for moving the cursor when developing a text editor.

```swift
let result = formatter.format(script, withCursorAtLocation: 38)
switch result {
case .success(let formatResult):
    print(formatResult.formattedString)
    print(formatResult.cursorOffset)
case .failure(let error):
    // Perform proper error handling.
    print(error)
}
```

Note that the result returned by `-format(:withCursorAtLocation:)` is different that the result returned
from both `-format()` and `-format(:limitedTo:)` because this one contains the location in the formatted string.

There are several properties that can be used to tweak the formatted code. These options map 1:1 to options in the JavaScript implementation of Prettier.
For more information on the options, please have a look at [PrettierFormatter.swift](https://github.com/simonbs/Prettier/blob/main/Sources/Prettier/PrettierFormatter.swift) as well as [the documentation for the JavaScript implementation of Prettier](https://prettier.io/docs/en/options.html).

### Language Detection

When creating an instance of PrettierFormatter you must specify the language of the code to format.
The Language type has initializers to help determine the language of a file given it's filename, file extension or both.

Languages can be detected from the file extension.

```swift
let language = Language(fileExtension: "js") // Detected: JavaScript
```

It can also be detected by specifying a file URL.

```swift
let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
let fileURL = directoryURL.appendingPathComponent("index.html")
let language = Language(fileURL: fileURL) // Detected: HTML
```

It also assumes the language of files with common names.

```swift
let language = Language(filename: "README") // Detected: Markdown
```

This logic is based on data stored in the [ikatyang/linguist-languages](https://github.com/ikatyang/linguist-languages) repository.

### Supported Languages

This package bundles the Prettier library along with support for the following languages and frameworks:

- Angular
- CSS
- Flow
- GraphQL
- HTML
- Handlebars
- JSON Stringify
- JSON With Comments
- JSON5
- JSX
- JavaScript
- Less
- Lightning Web Components
- MDX
- Markdown
- PHP
- PostCSS
- SCSS
- TSX
- TypeScript
- Vue
- YAML

## Acknowledgements

The package uses the following dependencies.

- [prettier/prettier](https://github.com/prettier/prettier)
- [prettier/plugin-php](https://github.com/prettier/plugin-php)

The language detection is inspired by the one in the JavaScript version of Prettier which depends on data from [ikatyang/linguist-languages](https://github.com/ikatyang/linguist-languages). Parts of the data stored in that repository was copied into this package.

## License

[MIT](https://github.com/simonbs/Prettier/blob/main/LICENSE)
