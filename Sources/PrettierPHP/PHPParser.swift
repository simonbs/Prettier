import Foundation
import Prettier

public struct PHPParser: Parser {
    public let name = "parser-php"
    public let fileURL = Bundle.module.url(forResource: "parser-php", withExtension: "js", subdirectory: "js")!

    public init() {}
}
