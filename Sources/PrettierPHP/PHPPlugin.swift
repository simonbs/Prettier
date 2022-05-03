import Foundation
import Prettier

public struct PHPPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-php", withExtension: "js", subdirectory: "js")!

    public init() {}
}
