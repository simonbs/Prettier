import Foundation
import JXKit

/// Error that can be returned by Prettier.
public enum PrettierFormatterError: LocalizedError {
    case unprepared
    case failedInitializingContext
    case failedCreatingConfiguration
    case failedCallingFormatFunction
    case unexpectedResultFromFormatFunction
    case parsingError(ParsingErrorDetails)
    case unknown

    public var errorDescription: String? {
        switch self {
        case .unprepared:
            return "Prettier has not been prepared. Call prepare() before formatting code"
        case .failedInitializingContext:
            return "Could not initialize the JavaScript context"
        case .failedCreatingConfiguration:
            return "Could not create the configuration JavaScript object"
        case .failedCallingFormatFunction:
            return "Failed calling the format() JavaScript function on Prettier"
        case .unexpectedResultFromFormatFunction:
            return "Expected a string result but got an unexpected result"
        case .parsingError(let error):
            return error.debugDescription
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

/// Takes unformatted code as input and outputs formatted code.
public final class PrettierFormatter {
    /// The length that the printer will wrap on.
    public var printWidth = 80
    /// The number of spaces per indentation-level.
    public var tabWidth = 2
    /// Indent lines with tabs instead of spaces.
    public var useTabs = false
    /// Print semicolons at the end of statements.
    public var semicolons = true
    /// Use single quotes instead of double quotes.
    public var singleQuote = false
    /// Specifies when properties are surrounded by quotes.
    public var quoteProperties: QuotePropertyStrategy = .asNeeded
    /// Use single quotes instead of double quotes in JSX.
    public var jsxSingleQuote = false
    /// Whether to use trailing commas or not.
    public var trailingCommas: TrailingCommaStrategy = .es5
    /// Add spaces between brackets in object literals.
    public var bracketSpacing = true
    /// Put the `>` of multi-line HTML element at the end of the last line instead of being alone on the next line. Does not apply to self closing elements.
    public var bracketSameLine = false
    /// Whether to include parentheses around a sole arrow function parameter.
    public var arrowFunctionParentheses: ArrowFunctionParenthesesStrategy = .always
    /// Specify how prose is wrapped when formatting markdown.
    public var proseWrap: ProseWrapStrategy = .preserve
    /// Specify the global whitespace sensitivity for HTML, Vue, Angular, and Handlebars.
    public var htmlWhitespaceSensitivity: HTMLWhitespaceSensitivityStrategy = .css
    /// Whether or not to indent the code inside `<script>` and `<style>`tags in Vue files.
    public var vueIndentScriptAndStyle = false
    /// Specify end line endings to be used.
    public var endOfLine: EndOfLineStrategy = .lf
    /// Whether Prettier formats quoted code embedded in the file.
    public var embeddedLanguageFormatting: EmbeddedLanguageFormattingStrategy = .auto

    private let plugins: [Plugin]
    private let parser: Parser
    private var isPrepared = false
    private var context = JXContext()

    /// Initializes Prettier to format code.
    /// - Parameter plugins: The plugins to load into Prettier.
    /// - Parameter parser: Parser to use for formatting the code.
    public init(plugins: [Plugin], parser: Parser) {
        self.plugins = plugins
        self.parser = parser
    }

    /// Prepares Prettier to format code. This must be called before calling any of the formatting functions. This function can be called well in advance to have the instance prepared to format code at a later time.
    public func prepare() throws {
        if !isPrepared {
            try loadScriptsIntoContext()
        }
    }

    /// Formats the inputted code.
    /// - Parameter code: Code to format.
    /// - Returns: Result carriying the formatted code.
    public func format(_ code: String) -> Result<String, PrettierFormatterError> {
        return makeConfiguration().flatMap { configuration in
            return format(code, withConfiguration: configuration)
        }.flatMap { value in
            return mapString(from: value)
        }
    }

    /// Formats the inputted code. Only the code in the specified range is formatted.
    /// - Parameters:
    ///   - code: String containing the code to be formatted.
    ///   - range: Range in the string where the code to be formatted resides.
    /// - Returns: Result carrying the formatted code.
    public func format(_ code: String, limitedTo range: ClosedRange<Int>) -> Result<String, PrettierFormatterError> {
        return makeConfiguration(range: range).flatMap { configuration in
            return format(code, withConfiguration: configuration)
        }.flatMap(mapString)
    }

    /// Formats the inputted code and translates the cursor location from the unformatted code to the formatted code.
    /// - Parameters:
    ///   - code: Code to format.
    ///   - cursorOffset: The cursor's current location in the code.
    /// - Returns: Result carrying the formatted code.
    public func format(_ code: String, withCursorAtLocation cursorOffset: Int) -> Result<FormatWithCursorResult, PrettierFormatterError> {
        return makeConfiguration(cursorOffset: cursorOffset).flatMap { configuration in
            return format(code, withConfiguration: configuration, prettierFunctionName: "formatWithCursor")
        }.flatMap(mapFormatWithCursorResult)
    }
}

private extension PrettierFormatter {
    private func format(_ code: String,
                        withConfiguration configuration: JXValue,
                        prettierFunctionName: String = "format") -> Result<JXValue, PrettierFormatterError> {
        guard let prettier = try? context.global["prettier"] else {
            return .failure(.unprepared)
        }
        guard prettier.isObject, let formatFunction = try? prettier[prettierFunctionName] else {
            return .failure(.failedCallingFormatFunction)
        }

        let result: JXValue
        do {
            result = try formatFunction.call(withArguments: [code, configuration])
            return .success(result)
        } catch {
            // TODO: Parse `ParsingErrorDetails`
            print(error)
            return .failure(.failedCallingFormatFunction)
        }
    }

    private func mapString(from value: JXValue) -> Result<String, PrettierFormatterError> {
        if value.isString, let string = try? value.string {
            return .success(string)
        } else {
            return .failure(.unexpectedResultFromFormatFunction)
        }
    }

    private func mapFormatWithCursorResult(from value: JXValue) -> Result<FormatWithCursorResult, PrettierFormatterError> {
        if value.isObject, let result = try? value.toDecodable(ofType: FormatWithCursorResult.self) {
            return .success(result)
        } else {
            return .failure(.unexpectedResultFromFormatFunction)
        }
    }

    private func loadScriptsIntoContext() throws {
        let standaloneFileURL = Bundle.module.url(forResource: "standalone", withExtension: "js")
        let pluginFileURLs = plugins.map(\.fileURL)
        let fileURLs = ([standaloneFileURL] + pluginFileURLs).compactMap { $0 }
        let script = fileURLs.compactMap { try? String(contentsOf: $0) }.joined(separator: "\n")
        do {
            try context.eval(script)
        } catch {
            throw PrettierFormatterError.failedInitializingContext
        }
    }

    private func makeConfiguration(range: ClosedRange<Int>? = nil, cursorOffset: Int? = nil) -> Result<JXValue, PrettierFormatterError> {
        guard let prettierPluginsValue = try? context.global["prettierPlugins"] else {
            return .failure(.failedCreatingConfiguration)
        }

        let configuration = Configuration(
            parser: parser.name,
            rangeStart: range?.lowerBound,
            rangeEnd: range?.upperBound,
            cursorOffset: cursorOffset,
            printWidth: printWidth,
            tabWidth: tabWidth,
            useTabs: useTabs,
            semicolons: semicolons,
            singleQuote: singleQuote,
            quoteProperties: quoteProperties.rawValue,
            jsxSingleQuote: jsxSingleQuote,
            trailingCommas: trailingCommas.rawValue,
            bracketSpacing: bracketSpacing,
            bracketSameLine: bracketSameLine,
            arrowFunctionParentheses: arrowFunctionParentheses.rawValue,
            proseWrap: proseWrap.rawValue,
            htmlWhitespaceSensitivity: htmlWhitespaceSensitivity.rawValue,
            vueIndentScriptAndStyle: vueIndentScriptAndStyle,
            endOfLine: endOfLine.rawValue,
            embeddedLanguageFormatting: embeddedLanguageFormatting.rawValue
        )

        let value: JXValue
        do {
            value = try context.encode(configuration)
            try value.setProperty("plugins", prettierPluginsValue)
        } catch {
            return .failure(.failedCreatingConfiguration)
        }

        return .success(value)
    }
}
