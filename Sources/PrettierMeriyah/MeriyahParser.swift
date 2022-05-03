import Foundation
import Prettier

public struct MeriyahParser: Parser {
    public let name = "parser-meriyah"
    public let fileURL = Bundle.module.url(forResource: "parser-meriyah", withExtension: "js", subdirectory: "js")!

    public init() {}
}
