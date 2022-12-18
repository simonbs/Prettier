import Foundation
import Prettier

public struct YAMLPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-yaml", withExtension: "js")!

    public init() {}
}
