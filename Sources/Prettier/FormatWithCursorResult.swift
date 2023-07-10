import Foundation

/// Result of formatting code with a cursor position.
public struct FormatWithCursorResult: Decodable {
    /// The new cursor position.
    public let cursorOffset: Int
    /// The formatted string.
    public let formattedString: String

    enum CodingKeys: String, CodingKey {
        case cursorOffset
        case formattedString = "formatted"
    }
}
