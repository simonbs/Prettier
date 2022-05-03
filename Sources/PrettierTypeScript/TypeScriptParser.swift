import Foundation
import Prettier

public struct TypeScriptParser: Parser {
    public let name = "parser-typescript"
    public let fileURL = Bundle.module.url(forResource: "parser-typescript", withExtension: "js", subdirectory: "js")!

    public init() {}
}
