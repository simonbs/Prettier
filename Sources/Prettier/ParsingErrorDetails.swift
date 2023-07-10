import Foundation
import JXKit

/// Details supplied by PrettierFormatterError when parsing fails.
public struct ParsingErrorDetails: Decodable, Equatable, CustomDebugStringConvertible {
    public let line: Int
    public let column: Int
    public let codeFrame: String
    public var debugDescription: String {
        return "Parsing error at line \(line), column \(column):\n\(codeFrame)"
    }

    public init(line: Int, column: Int, codeFrame: String) {
        self.line = line
        self.column = column
        self.codeFrame = codeFrame
    }

    init?(error: JXError) {
        let lines = error.description.split(separator: "\n")
        guard let jsScript = error.script, lines.count >= 2, lines[0].hasPrefix("SyntaxError:") else {
            return nil
        }

        let posString = lines[0].split(separator: "(", maxSplits: 1)
        guard posString.count == 2, posString[1].hasSuffix(")") else {
            return nil
        }

        let posParts = posString[1].dropLast().split(separator: ":", maxSplits: 1)
        guard posParts.count == 2 else {
            return nil
        }

        guard let line = Int(posParts[0]), let column = Int(posParts[1]) else {
            return nil
        }

        self.line = line
        self.column = column

        let jsErrorDescriptor = "<<script: \(jsScript) >>"
        codeFrame = lines.dropFirst()
            .joined(separator: "\n")
            .replacingOccurrences(of: jsErrorDescriptor, with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
