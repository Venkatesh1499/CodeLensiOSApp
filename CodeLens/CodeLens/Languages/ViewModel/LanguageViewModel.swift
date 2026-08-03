import Foundation
import Combine

class LanguageViewModel: ObservableObject {
    
    @Published var selectedLanguage: String = ""
    @Published var searchText: String = ""
    @Published var shouldNavigateToCodeEditor: Bool = false
    @Published var shouldShowLogoutPreconfirmation: Bool = false
    
    var selected = UUID()
    
    var storedLanguages: [Language] = []
    
    @Published var languages: [Language] = []
    
    init() {
        self.languages = loadJsonData()
        self.storedLanguages = languages
    }
    
    func loadJsonData() -> [Language] {
        guard let path = Bundle.main.url(forResource: "languageDetails", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: path)
            
            let decoded = try JSONDecoder().decode([Language].self, from: data)
            return decoded
        } catch {
            print("error while decoding")
            return []
        }
    }
    
    func showSearchResult() {
        if searchText.isEmpty {
            languages = storedLanguages
        } else {
            languages = storedLanguages.filter { $0.name.contains(searchText) }
        }
    }
}
