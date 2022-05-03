import Foundation
import Prettier

public struct EspreeParser: Parser {
    public let name = "parser-espree"
    public let fileURL = Bundle.module.url(forResource: "parser-espree", withExtension: "js", subdirectory: "js")!

    public init() {}
}
