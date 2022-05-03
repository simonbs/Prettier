import Foundation
import Prettier

public struct GraphQLParser: Parser {
    public let name = "parser-graphql"
    public let fileURL = Bundle.module.url(forResource: "parser-graphql", withExtension: "js", subdirectory: "js")!

    public init() {}
}
