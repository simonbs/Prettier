import XCTest
@testable import Prettier

final class LanguageTests: XCTestCase {
    func testMatchOnFilename() {
        let language = Language(filename: "README")
        XCTAssertEqual(language, .markdown)
    }

    func testMatchOnFileExtension() {
        let language = Language(fileExtension: "js")
        XCTAssertEqual(language, .javaScript)
    }

    func testMatchOnFileURL() {
        let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = directoryURL.appendingPathComponent("index.html")
        let language = Language(fileURL: fileURL)
        XCTAssertEqual(language, .html)
    }

    func testUnsupportedFilename() {
        let language = Language(filename: "index.html")
        XCTAssertEqual(language, nil)
    }

    func testUnsupportedFileExtension() {
        let language = Language(fileExtension: "py")
        XCTAssertEqual(language, nil)
    }

    func testUnsupportedFileURL() {
        let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = directoryURL.appendingPathComponent("main.py")
        let language = Language(fileURL: fileURL)
        XCTAssertEqual(language, nil)
    }
}
