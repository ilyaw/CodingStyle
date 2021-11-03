enum Style {
    case camelCase, snakeCase, kebabCase
}

///snake_case_example
///CamelCaseExample
///kebab-case-example
@propertyWrapper struct CodingStyle {
    private var storedString = ""
    
    var wrappedValue: String {
        get {
            return transformStringToCase()
        }
        set {
            storedString = newValue
        }
    }
    
    private var style: Style
    
    init(wrappedValue: String, style: Style) {
        self.storedString = wrappedValue
        self.style = style
    }
    
    private func transformStringToCase() -> String {
        switch style {
        case .camelCase:
            return stringToCamelCase()
        case .snakeCase:
            return stringToSnakeCase()
        case .kebabCase:
            return stringToKebabCase()
        }
    }
    
    private func stringToCamelCase() -> String {
        return storedString
            .split(whereSeparator: { $0.isPunctuation || $0.isWhitespace })
            .map { $0.lowercased().firstUppercased  }
            .joined()
    }
    
    private func stringToSnakeCase() -> String {
        return splittingWords().joined(separator: "_")
    }
    
    private func stringToKebabCase() -> String {
        return splittingWords().joined(separator: "-")
    }
    
    private func splittingWords() -> [String] {
        var result: [String] = []
        
        let splitWords = storedString.split(whereSeparator: { $0.isPunctuation || $0.isWhitespace })
        
        for word in splitWords {
            if word.count <= 1 {
                result.append(word.lowercased())
                continue
            }
            
            let countChars = word.count
            var indices: [Int] = []
            
            for (index, item) in word.enumerated() where item.isUppercase {
                indices.append(index)
            }
            
            let countUppercase = indices.count
            
            if countUppercase > 1 && countUppercase < countChars {
                for index in 0..<countUppercase {
                    let startIndex = indices[index]
                    let endIndex: Int
                    
                    if index+1 >= countUppercase {
                        endIndex = word.count
                    } else {
                        endIndex = indices[index+1]
                    }
                    
                    result.append(word[startIndex..<endIndex].lowercased())
                }
            } else {
                result.append(word.lowercased())
            }
        }
        
        return result
    }
    
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}

extension String.SubSequence {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }
    
    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }
    
}
