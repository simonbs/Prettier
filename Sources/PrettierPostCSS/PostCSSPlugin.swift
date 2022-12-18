import Foundation
import Prettier

public struct PostCSSPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-postcss", withExtension: "js")!

    public init() {}
}
