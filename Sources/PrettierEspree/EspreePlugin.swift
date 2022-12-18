import Foundation
import Prettier

public struct EspreePlugin: Plugin {
    public let fileURL = Bundle.module.url(forResource: "parser-espree", withExtension: "js")!

    public init() {}
}
