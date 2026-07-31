//
//  LanguageViewModel.swift
//  Languages
//
//  Created by Venkatesh Nimmalapudi on 15/07/26.
//
import Foundation
import Combine

class LanguageViewModel: ObservableObject {
    
    @Published var selectedLanguage: String = ""
    @Published var shouldNavigateToCodeEditor: Bool = false
    @Published var shouldShowLogoutPreconfirmation: Bool = false
    
    var selected = UUID()
    
    var languages: [Language] = []
    
    init() {
        self.languages = loadJsonData()
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
}
