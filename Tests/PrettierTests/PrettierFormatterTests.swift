import Prettier
import PrettierBabel
import PrettierHTML
import PrettierMarkdown
import PrettierPHP
import PrettierPostCSS
import XCTest

// swiftlint:disable:next type_body_length
final class PrettierTests: XCTestCase {
    func testInitialDocExample() {
        let input = """
foo(reallyLongArg(), omgSoManyParameters(), IShouldRefactorThis(), isThereSeriouslyAnotherOne());
"""
        let output = """
foo(
  reallyLongArg(),
  omgSoManyParameters(),
  IShouldRefactorThis(),
  isThereSeriouslyAnotherOne()
);

"""
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testUntouched() {
        let input = "foo(arg1, arg2, arg3, arg4);"
        let output = "foo(arg1, arg2, arg3, arg4);\n"
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testPHP() {
        let input = """
<?php
array_map(function($arg1,$arg2) use ( $var1, $var2 ) {
    return $arg1+$arg2/($var+$var2);
}, array("complex"=>"code","with"=>
    function() {return "inconsistent";}
,"formatting"=>"is", "hard" => "to", "maintain"=>true));
"""
        let output = """
<?php
array_map(
  function ($arg1, $arg2) use ($var1, $var2) {
    return $arg1 + $arg2 / ($var + $var2);
  },
  [
    "complex" => "code",
    "with" => function () {
      return "inconsistent";
    },
    "formatting" => "is",
    "hard" => "to",
    "maintain" => true,
  ]
);

"""
        let formatter = PrettierFormatter(plugins: [PHPPlugin()], parser: PHPParser())
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testMarkdown() {
        let input = """
const foo      = 'bar'



   console     .log(    213    )
"""
        let output = """
const foo = 'bar'

console .log( 213 )

"""
        let formatter = PrettierFormatter(plugins: [MarkdownPlugin()], parser: MarkdownParser())
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testTabWidth() {
        let input = "if (hello == \"world\") { return \"Hello world\" }"
        let output = "if (hello == \"world\") {\n        return \"Hello world\";\n}\n"
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.tabWidth = 8
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testTabsInsteadOfSpaces() {
        let input = "if (hello == \"world\") { return \"Hello world\" }"
        let output = "if (hello == \"world\") {\n\treturn \"Hello world\";\n}\n"
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.useTabs = true
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testSemicolonsDisables() {
        let input = "if (hello == \"world\") { return \"Hello world\" }"
        let output = "if (hello == \"world\") {\n  return \"Hello world\"\n}\n"
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.semicolons = false
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testFormattingRangeOfCode() {
        let input = "if(hello==\"world\"){\nreturn\"Hello world\"\n}"
        let output = "if(hello==\"world\"){\nreturn \"Hello world\";\n}"
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.prepare()
        let result = formatter.format(input, limitedTo: 20 ... 39)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testFormattingWithCursorLocation() {
        let input = "if(hello==\"world\"){\nreturn\"Hello world\"\n}"
        let output = "if (hello == \"world\") {\n  return \"Hello world\";\n}\n"
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: BabelParser())
        formatter.prepare()
        let result = formatter.format(input, withCursorAtLocation: 38)
        switch result {
        case .success(let formatResult):
            XCTAssertEqual(formatResult.formattedString, output)
            XCTAssertEqual(formatResult.cursorOffset, 45)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    // swiftlint:disable:next function_body_length
    func testHTMLWithCSSAndJavaScript() {
        let input = """
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Example Website</title>
    <meta name="author" content="name" />
    <meta name="description" content="This is an example website" />
    <meta name="keywords" content="best,ever,example,website" />
    <style type="text/css">
      body {
            background: #fff;
            color: #000;
            font-size: 1.5em;
            font-family: -apple-system, sans-serif;
          }
          @media (prefers-color-scheme: dark) {
            body {
              background: #000;
              color: #fff;
            }
          }
    </style>
  </head>
  <body>
    <p>Things I like about this website:</p>
    <ul>
      <li>It loads fast.</li>
      <li>It supports dark mode</li>
      <li>Otherwise nothing really.</li>
    </ul>
    <script type="text/javascript">
      function greet() {
          alert("Welcome to the example website 👋")
      }
      // Let's hope visitors won't find the popup annoying.
      window.onload = greet;
    </script>
  </body>
</html>
"""
        let output = """
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Example Website</title>
    <meta name="author" content="name" />
    <meta name="description" content="This is an example website" />
    <meta name="keywords" content="best,ever,example,website" />
    <style type="text/css">
      body {
        background: #fff;
        color: #000;
        font-size: 1.5em;
        font-family: -apple-system, sans-serif;
      }
      @media (prefers-color-scheme: dark) {
        body {
          background: #000;
          color: #fff;
        }
      }
    </style>
  </head>
  <body>
    <p>Things I like about this website:</p>
    <ul>
      <li>It loads fast.</li>
      <li>It supports dark mode</li>
      <li>Otherwise nothing really.</li>
    </ul>
    <script type="text/javascript">
      function greet() {
        alert("Welcome to the example website 👋");
      }
      // Let's hope visitors won't find the popup annoying.
      window.onload = greet;
    </script>
  </body>
</html>

"""
        let formatter = PrettierFormatter(plugins: [
            HTMLPlugin(), PostCSSPlugin(), BabelPlugin()
        ], parser: HTMLParser())
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testJSON() {
        let input = """
{"allOn": "Single", "Line": "example",
"noSpace":true,
  "quote": {
    'singleQuote': 'example',
                  "indented": true,
  },
  "phoneNumbers": [
    {"type": "home",
      "number": "212 555-1234"},
    {"type": "office",
      "trailing": "commas by accident"},
  ],
}
"""
        let output = """
{
  "allOn": "Single",
  "Line": "example",
  "noSpace": true,
  "quote": {
    "singleQuote": "example",
    "indented": true
  },
  "phoneNumbers": [
    { "type": "home", "number": "212 555-1234" },
    { "type": "office", "trailing": "commas by accident" }
  ]
}

"""
        let formatter = PrettierFormatter(plugins: [BabelPlugin()], parser: JSONParser())
        formatter.prepare()
        let result = formatter.format(input)
        switch result {
        case .success(let result):
            XCTAssertEqual(result, output)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
}
