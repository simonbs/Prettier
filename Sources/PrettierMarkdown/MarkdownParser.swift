import Foundation
import Prettier

public struct MarkdownParser: Parser {
    public let name = "parser-markdown"
    public let fileURL = Bundle.module.url(forResource: "parser-markdown", withExtension: "js", subdirectory: "js")!

    public init() {}
}
