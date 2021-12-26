extension Language {
    var filenames: [String] {
        switch self {
        case .css, .postCSS, .less, .scss:
            return []

        case .graphQL:
            return []

        case .handlebars:
            return []

        case .angular, .html, .lightingWebComponents, .vue:
            return []

        case .javaScript:
            return ["Jakefile"]
        case .jsonStringify:
            return ["package.json", "package-lock.json", "composer.json"]
        case .json:
            return [
                ".arcconfig",
                ".htmlhintrc",
                ".imgbotconfig",
                ".tern-config",
                ".tern-project",
                ".watchmanconfig",
                "Pipfile.lock",
                "composer.lock",
                "mcmod.info"
            ]
        case .jsonWithComments:
            return [
                ".babelrc",
                ".eslintrc.json",
                ".jscsrc",
                ".jshintrc",
                ".jslintrc",
                "api-extractor.json",
                "devcontainer.json",
                "jsconfig.json",
                "language-configuration.json",
                "tsconfig.json",
                "tslint.json",
                ".eslintrc"
            ]
        case .flow, .jsx, .typeScript, .tsx, .json5:
            return []

        case .markdown:
            return ["contents.lr", "README"]
        case .mdx:
            return []

        case .yaml:
            return [
                ".clang-format",
                ".clang-tidy",
                ".gemrc",
                "glide.lock",
                ".prettierrc",
                ".stylelintrc"
            ]

        case .php:
            return [
                ".php",
                ".php_cs",
                ".php_cs.dist",
                "Phakefile"
            ]

        case .ruby:
            return [
                ".irbrc",
                ".pryrc",
                ".simplecov",
                "Appraisals",
                "Berksfile",
                "Brewfile",
                "Buildfile",
                "Capfile",
                "Dangerfile",
                "Deliverfile",
                "Fastfile",
                "Gemfile",
                "Guardfile",
                "Jarfile",
                "Mavenfile",
                "Podfile",
                "Puppetfile",
                "Rakefile",
                "Snapfile",
                "Thorfile",
                "Vagrantfile",
                "buildfile"
            ]
        }
    }
}
