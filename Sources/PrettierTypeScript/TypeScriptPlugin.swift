import Foundation
import Prettier

public struct TypeScriptPlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-typescript", withExtension: "js", subdirectory: "js")!

    public init() {}
}
