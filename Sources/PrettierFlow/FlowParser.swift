import Foundation
import Prettier

public struct FlowParser: Parser {
    public let name = "parser-flow"
    public let fileURL = Bundle.module.url(forResource: "parser-flow", withExtension: "js", subdirectory: "js")!

    public init() {}
}
