import Foundation
import Prettier

public struct GlimmerPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-glimmer", withExtension: "js", subdirectory: "js")!

    public init() {}
}
