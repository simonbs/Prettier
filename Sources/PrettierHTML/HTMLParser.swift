import Foundation
import Prettier

public struct HTMLParser: Parser {
    public let name = "parser-html"
    public let fileURL = Bundle.module.url(forResource: "parser-html", withExtension: "js", subdirectory: "js")!

    public init() {}
}
