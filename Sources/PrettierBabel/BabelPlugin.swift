import Foundation
import Prettier

public struct BabelPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-babel", withExtension: "js")!

    public init() {}
}
