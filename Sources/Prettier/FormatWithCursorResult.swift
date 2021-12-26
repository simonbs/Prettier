import Foundation

public struct FormatWithCursorResult {
    public let cursorOffset: Int
    public let formattedString: String

    init(cursorOffset: Int, formattedString: String) {
        self.cursorOffset = cursorOffset
        self.formattedString = formattedString
    }

    init?(object: [String: Any]) {
        guard let cursorOffset = object["cursorOffset"] as? Int else {
            return nil
        }
        guard let formattedString = object["formatted"] as? String else {
            return nil
        }
        self.cursorOffset = cursorOffset
        self.formattedString = formattedString
    }
}
