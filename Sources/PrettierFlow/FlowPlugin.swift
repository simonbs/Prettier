import Foundation
import Prettier

public struct FlowPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-flow", withExtension: "js", subdirectory: "js")!

    public init() {}
}
