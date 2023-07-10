import JXKit

struct Configuration: Encodable {
    let parser: String
    let rangeStart: Int?
    let rangeEnd: Int?
    let cursorOffset: Int?
    let printWidth: Int
    let tabWidth: Int
    let useTabs: Bool
    let semicolons: Bool
    let singleQuote: Bool
    let quoteProperties: String
    let jsxSingleQuote: Bool
    let trailingCommas: String
    let bracketSpacing: Bool
    let bracketSameLine: Bool
    let arrowFunctionParentheses: String
    let proseWrap: String
    let htmlWhitespaceSensitivity: String
    let vueIndentScriptAndStyle: Bool
    let endOfLine: String
    let embeddedLanguageFormatting: String

    enum CodingKeys: String, CodingKey {
        case parser
        case rangeStart
        case rangeEnd
        case cursorOffset
        case printWidth
        case tabWidth
        case useTabs
        case semicolons = "semi"
        case singleQuote
        case quoteProperties = "quoteProps"
        case jsxSingleQuote
        case trailingCommas = "trailingComma"
        case bracketSpacing
        case bracketSameLine
        case arrowFunctionParentheses = "arrowParens"
        case proseWrap
        case htmlWhitespaceSensitivity
        case vueIndentScriptAndStyle
        case endOfLine
        case embeddedLanguageFormatting
    }
}
