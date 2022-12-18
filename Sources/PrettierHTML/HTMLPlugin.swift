import Foundation
import Prettier

public struct HTMLPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-html", withExtension: "js")!

    public init() {}
}
