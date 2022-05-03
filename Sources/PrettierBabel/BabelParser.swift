import Foundation
import Prettier

public struct BabelParser: Parser {
    public let name = "parser-babel"
    public let fileURL = Bundle.module.url(forResource: "parser-babel", withExtension: "js", subdirectory: "js")!

    public init() {}
}
