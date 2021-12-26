import Foundation

public extension Language {
    init?(fileURL: URL) {
        if let language = Self(filename: fileURL.lastPathComponent) {
            self = language
        } else if !fileURL.pathExtension.isEmpty, let language = Self(fileExtension: fileURL.pathExtension) {
            self = language
        } else {
            return nil
        }
    }

    init?(filename: String) {
        if let language = Self.language(forFilename: filename) {
            self = language
        } else {
            return nil
        }
    }

    init?(fileExtension: String) {
        if let language = Self.language(forFileExtension: fileExtension) {
            self = language
        } else {
            return nil
        }
    }
}

private extension Language {
    private static func language(forFilename filename: String) -> Language? {
        for language in Language.allCases {
            if language.filenames.contains(filename) {
                return language
            }
        }
        return nil
    }

    private static func language(forFileExtension fileExtension: String) -> Language? {
        for language in Language.allCases {
            if language.fileExtensions.contains("." + fileExtension) {
                return language
            }
        }
        return nil
    }
}
