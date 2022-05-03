import Foundation

/// A parser that can be used with Prettier to format code.
public protocol Parser {
    var name: String { get }
    var fileURL: URL { get }
}
