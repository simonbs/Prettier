import Foundation
import Prettier

public struct YAMLParser: Parser {
    public let name = "parser-yaml"
    public let fileURL = Bundle.module.url(forResource: "parser-yaml", withExtension: "js", subdirectory: "js")!

    public init() {}
}
