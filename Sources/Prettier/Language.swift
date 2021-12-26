import Foundation

/// Language that can be used with Prettier to format code.
public enum Language: CaseIterable {
    case css
    case postCSS
    case less
    case scss

    case graphQL

    case handlebars

    case angular
    case html
    case lightingWebComponents
    case vue

    case javaScript
    case flow
    case jsx
    case typeScript
    case tsx
    case jsonStringify
    case json
    case jsonWithComments
    case json5

    case markdown
    case mdx

    case yaml

    case php

    case ruby

    var parserName: String {
        return parsers[0].rawValue
    }

    var parsers: [Parser] {
        switch self {
        case .css, .postCSS:
            return [.css]
        case .less:
            return [.less]
        case .scss:
            return [.scss]

        case .graphQL:
            return [.graphQL]

        case .handlebars:
            return [.glimmer]

        case .angular:
            return [.angular]
        case .html:
            return [.html]
        case .lightingWebComponents:
            return [.lwc]
        case .vue:
            return [.vue]

        case .javaScript:
            return [.babel, .espree, .meriyah, .babelFlow, .babelTS, .flow, .typeScript]
        case .flow:
            return [.flow, .babelFlow]
        case .jsx:
            return [.babel, .babelFlow, .babelTS, .flow, .typeScript, .espree, .meriyah]
        case .typeScript:
            return [.typeScript, .babelTS]
        case .tsx:
            return [.typeScript, .babelTS]
        case .jsonStringify:
            return [.jsonStringify]
        case .json:
            return [.json]
        case .jsonWithComments:
            return [.json]
        case .json5:
            return [.json5]

        case .markdown:
            return [.markdown]
        case .mdx:
            return [.mdx]

        case .yaml:
            return [.yaml]

        case .php:
            return [.php]

        case .ruby:
            return [.ruby]
        }
    }
}
