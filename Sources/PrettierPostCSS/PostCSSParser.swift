import Foundation
import Prettier

public struct PostCSSParser: Parser {
    public let name = "parser-postcss"
    public let fileURL = Bundle.module.url(forResource: "parser-postcss", withExtension: "js", subdirectory: "js")!

    public init() {}
}
