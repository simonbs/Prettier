import Foundation
import Prettier

public struct MarkdownPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-markdown", withExtension: "js")!

    public init() {}
}
