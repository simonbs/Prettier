import Foundation

/// Details supplied by PrettierFormatterError when parsing fails.
public struct ParsingErrorDetails: Decodable, CustomDebugStringConvertible {
    public let line: Int
    public let column: Int
    public let codeFrame: String
    public var debugDescription: String {
        return "Parsing error at line \(line), column \(column):\n\(codeFrame)"
    }

    struct PrettierErrorRange: Decodable {
        let start: PrettierErrorLocation

        struct PrettierErrorLocation: Decodable {
            let line: Int
            let column: Int
        }
    }

    enum CodingKeys: CodingKey {
        case codeFrame
        case loc
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        codeFrame = try container.decode(String.self, forKey: .codeFrame)
        let loc = try container.decode(PrettierErrorRange.self, forKey: .loc)

        self.line = loc.start.line
        self.column = loc.start.column
    }
}
