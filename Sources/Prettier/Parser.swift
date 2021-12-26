import Foundation

public enum Parser: String {
    case angular
    case babel
    case babelFlow = "babel-flow"
    case babelTS = "babel-ts"
    case css
    case espree
    case flow
    case glimmer
    case graphQL
    case html
    case json
    case json5
    case jsonStringify = "json-stringify"
    case less
    case lwc
    case markdown
    case mdx
    case meriyah
    case php
    case ruby
    case scss
    case typeScript
    case vue
    case yaml

    var filename: String {
        return pluginName
    }

    var pluginName: String {
        switch self {
        case .angular:
            return "parser-html"
        case .babel:
            return "parser-babel"
        case .babelFlow:
            return "parser-babel"
        case .babelTS:
            return "parser-babel"
        case .css:
            return "parser-postcss"
        case .espree:
            return "parser-espree"
        case .flow:
            return "parser-flow"
        case .glimmer:
            return "parser-glimmer"
        case .graphQL:
            return "parser-graphql"
        case .html:
            return "parser-html"
        case .json:
            return "parser-babel"
        case .json5:
            return "parser-babel"
        case .jsonStringify:
            return "parser-babel"
        case .less:
            return "parser-postcss"
        case .lwc:
            return "parser-html"
        case .markdown:
            return "parser-markdown"
        case .mdx:
            return "parser-markdown"
        case .meriyah:
            return "parser-meriyah"
        case .php:
            return "parser-php"
        case .ruby:
            return "parser-ruby"
        case .scss:
            return "parser-postcss"
        case .typeScript:
            return "parser-typescript"
        case .vue:
            return "parser-html"
        case .yaml:
            return "parser-yaml"
        }
    }
}
