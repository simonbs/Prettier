import Foundation
import Prettier

public struct GlimmerParser: Parser {
    public let name = "parser-glimmer"
    public let fileURL = Bundle.module.url(forResource: "parser-glimmer", withExtension: "js", subdirectory: "js")!

    public init() {}
}
