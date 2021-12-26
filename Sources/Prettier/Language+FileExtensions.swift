import Foundation

extension Language {
    var fileExtensions: [String] {
        switch self {
        case .css:
            return [".css", ".wxss"]
        case .postCSS:
            return [".pcss", ".postcss"]
        case .less:
            return [".less"]
        case .scss:
            return [".scss"]

        case .graphQL:
            return [".graphql", ".gql", ".graphqls"]

        case .handlebars:
            return [".handlebars", ".hbs"]

        case .angular:
            return [".component.html"]
        case .html:
            return [
                ".html",
                ".htm",
                ".html.hl",
                ".inc",
                ".xht",
                ".xhtml",
                ".mjml"
            ]
        case .lightningWebComponents:
            return []
        case .vue:
            return [".vue"]

        case .javaScript:
            return [
                ".js",
                "._js",
                ".bones",
                ".cjs",
                ".es",
                ".es6",
                ".frag",
                ".gs",
                ".jake",
                ".jsb",
                ".jscad",
                ".jsfl",
                ".jsm",
                ".jss",
                ".mjs",
                ".njs",
                ".pac",
                ".sjs",
                ".ssjs",
                ".xsjs",
                ".xsjslib",
                ".wsx"
            ]
        case .flow:
            return [".js.flow"]
        case .jsx:
            return [".jsx"]
        case .typeScript:
            return [".ts", ".mts", ".cts"]
        case .tsx:
            return [".tsx"]
        case .jsonStringify:
            return []
        case .json:
            return [
                ".json",
                ".avsc",
                ".geojson",
                ".gltf",
                ".har",
                ".ice",
                ".JSON-tmLanguage",
                ".mcmeta",
                ".tfstate",
                ".tfstate.backup",
                ".topojson",
                ".webapp",
                ".webmanifest",
                ".yy",
                ".yyp"
            ]
        case .jsonWithComments:
            return [
                ".jsonc",
                ".sublime-build",
                ".sublime-commands",
                ".sublime-completions",
                ".sublime-keymap",
                ".sublime-macro",
                ".sublime-menu",
                ".sublime-mousemap",
                ".sublime-project",
                ".sublime-settings",
                ".sublime-theme",
                ".sublime-workspace",
                ".sublime_metrics",
                ".sublime_session"
            ]
        case .json5:
            return [".json5"]

        case .markdown:
            return [
                ".md",
                ".markdown",
                ".mdown",
                ".mdwn",
                ".mkd",
                ".mkdn",
                ".mkdown",
                ".ronn",
                ".scd",
                ".workbook"
            ]
        case .mdx:
            return [".mdx"]

        case .yaml:
            return [
                ".yml",
                ".mir",
                ".reek",
                ".rviz",
                ".sublime-syntax",
                ".syntax",
                ".yaml",
                ".yaml-tmlanguage",
                ".yaml.sed",
                ".yml.mysql"
            ]

        case .php:
            return [
                ".php",
                ".aw",
                ".ctp",
                ".fcgi",
                ".inc",
                ".php3",
                ".php4",
                ".php5",
                ".phps",
                ".phpt"
            ]

        case .ruby:
            return [
                ".rb",
                ".builder",
                ".eye",
                ".fcgi",
                ".gemspec",
                ".god",
                ".jbuilder",
                ".mspec",
                ".pluginspec",
                ".podspec",
                ".prawn",
                ".rabl",
                ".rake",
                ".rbi",
                ".rbuild",
                ".rbw",
                ".rbx",
                ".ru",
                ".ruby",
                ".spec",
                ".thor",
                ".watchr"
            ]
        }
    }
}
