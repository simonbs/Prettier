import XCTest
@testable import Prettier

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
        let formatter = PrettierFormatter(language: .javaScript)
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
        let formatter = PrettierFormatter(language: .javaScript)
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
        let formatter = PrettierFormatter(language: .php)
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
        let formatter = PrettierFormatter(language: .markdown)
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
        let formatter = PrettierFormatter(language: .javaScript)
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
        let formatter = PrettierFormatter(language: .javaScript)
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
        let formatter = PrettierFormatter(language: .javaScript)
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
        let formatter = PrettierFormatter(language: .javaScript)
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
        let formatter = PrettierFormatter(language: .javaScript)
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
}
