//
//  CodeEditorViewModel.swift
//  MainCodeArea
//
//  Created by Venkatesh Nimmalapudi on 18/07/26.
//

import SwiftUI
import Combine

class CodeEditorViewModel: ObservableObject {
    
    @Published var code: String = """
        """
    
    @Published var isLoading: Bool = false
    
    @Published var shouldShowSplashScreen: Bool = false
    
    @State var quickActive: QuickAction? = nil
    
    @Published var shouldNavigateToResultView: Bool = false
    
    @Published var issues: [String : [CategoryDetails]] = [:]
    
    var reviewAPIResponse: ReviewResponse? {
        didSet {
            guard let response = reviewAPIResponse else { return }
            shouldNavigateToResultView.toggle()
            issues = response.review.issues
        }
    }
    
    var selectedLanguage: String
    
    @Published var shouldSelectAll: Bool = false
    
    init(selectedLanguage: String) {
        self.selectedLanguage = selectedLanguage
    }
    
    func performAction(action: QuickActionType, value: String? = nil) async {
        switch action {
        case .selectAll:
            shouldSelectAll.toggle()
        case .clear:
            code = ""
        case .paste:
            DispatchQueue.main.async {
                self.code += UIPasteboard.general.string ?? ""
            }
        case .format:
            // TODO: - Need to call ann API to update the UI
            let request = CodeDetails(language: "python", code: code)
            await initiateFormatting(for: request)
            break
        }
    }
    
    // To remove extra escape sequences
    func decodeEscapedString(_ value: String) -> String? {
        let wrapped = "\"\(value)\""

        guard let data = wrapped.data(using: .utf8) else {
            return nil
        }

        return try? JSONDecoder().decode(String.self, from: data)
    }
}

extension CodeEditorViewModel {
    
    func initiateReview() async {
        do {
            let input = CodeDetails(language: selectedLanguage, code: code)
            let response: ReviewResponse = try await APIServiceManager.shared.initiateAPICall(with: EndPoint.review,
                                                                                              requestInput: input,
                                                                                              method: .post)
            reviewAPIResponse = response
//            shouldNavigateToResultView.toggle()
            print(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func initiateFormatting(for input: RequestInput) async {
        do {
            isLoading = true
            let response: FormatResponse = try await APIServiceManager.shared.initiateAPICall(with: EndPoint.format,
                                                                                              requestInput: input,
                                                                                              method: .post)
            isLoading = false
            handleFormatAPIResponse(response: response)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension CodeEditorViewModel {
    
    func handleFormatAPIResponse(response: FormatResponse) {
        if let error = response.error {
            print(error)
        } else if let formattedCode = response.formattedCode {
            DispatchQueue.main.async {
                self.code = formattedCode
            }
        }
    }
}
