import Foundation
import Prettier

public struct AngularParser: Parser {
    public let name = "parser-angular"
    public let fileURL = Bundle.module.url(forResource: "parser-angular", withExtension: "js", subdirectory: "js")!

    public init() {}
}
