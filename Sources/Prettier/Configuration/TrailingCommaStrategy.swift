// swiftlint:disable discouraged_none_name
import Foundation

/// Strategy determining whether to use trailing commas in formatted code.
public enum TrailingCommaStrategy: String, Codable {
    /// Trailing commas where valid in ES5 (objects, arrays, etc.). No trailing commas in type parameters in TypeScript.
    case es5
    /// No trailing commas.
    case none
    /// Trailing commas wherever possible.
    case all
}
