import Foundation
import Prettier

public struct MeriyahPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-meriyah", withExtension: "js")!

    public init() {}
}
