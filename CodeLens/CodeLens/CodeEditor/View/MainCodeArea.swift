import SwiftUI

struct MainCodeArea: View {
    
    @StateObject var viewModel: CodeEditorViewModel
    
    init(selectedLanguage: String) {
        self._viewModel = StateObject(wrappedValue: CodeEditorViewModel(selectedLanguage: selectedLanguage))
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
//                Color(hex: "#111827") //0D1117
                LinearGradient(
                    colors: [
                        Color(hex: "#0F172A"),
                        Color(hex: "#1E293B")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
//                LinearGradient(
//                    colors: [
//                        Color(hex: "#020617"),
//                        Color(hex: "#0F172A")
//                    ],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
                    .ignoresSafeArea(edges: .all)
                
                VStack(alignment: .leading, spacing: 15) {
                    titleAndSubtitle
                        .padding(.bottom, 5)
                    
                    Text("Languague")
                        .foregroundStyle(Color(.lightGray))
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                    
                    languageChangeView
                        .padding(.bottom, 10)
                    
                    codeEditorView(with: $viewModel.code)
                        .overlay(alignment: .bottom) {
                            if viewModel.shouldShowError {
                                withAnimation {
                                    ErrorView(title: "Review request failed", subTitle: "Something went wrong. Please try again.")
                                }
                            }
                        }
                        .onChange(of: viewModel.shouldShowError) {
                            removeErrorView()
                        }
                    
                    easyMenu
                    
                    Spacer()
                    
                    ReviewButton(shouldDisable: viewModel.code.isEmpty) {
                        Task {
                            await viewModel.initiateReview()
                        }
                    }
                    
                }
                .padding()
                
                if viewModel.isLoading {
                    AnimationView()
                }
            }
        }
        .logoutButton(title: "Code editor") {
            viewModel.shouldShowLogoutPreconfirmation.toggle()
        }
        .popup(isPresented: $viewModel.shouldShowLogoutPreconfirmation) {
            LogoutPreConfirmationPopUp {
                viewModel.shouldShowLogoutPreconfirmation.toggle()
            } onTapCancel: {
                viewModel.shouldShowLogoutPreconfirmation.toggle()
            }
        }

        .navigationDestination(isPresented: $viewModel.shouldNavigateToResultView) {
            ReviewResultView(language: viewModel.selectedLanguage,
                             codeReviewResponse: viewModel.reviewAPIResponse,
                             issues: viewModel.issues)
        }
    }
    
    // This is the main code editor part
    private func codeEditorView(with code: Binding<String>) -> some View {
        let array = code.wrappedValue.split(separator: "\n", omittingEmptySubsequences: false)
        let count = max(1, array.count)
        return
        ScrollView(.vertical) {
            HStack {
                VStack {
                    ForEach(0..<count, id: \.self) { num in
                        Text("\(num + 1) |")
                            .foregroundStyle(Color(hex: "#858585"))
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(maxWidth: 50, alignment: .trailing)
                    }
                }
                .frame(maxWidth: 50, alignment: .trailing)
                CodeEditor(text: code,
                           shouldSelectAll: $viewModel.shouldSelectAll,
                           language: viewModel.selectedLanguage)
            }
        }
        .background(Color(hex: "#1E1E1E"))
        .frame(maxHeight: 380)
        .cornerRadius(12)
    }
    
    private var titleAndSubtitle: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Paste your code")
                .foregroundStyle(.white)
                .font(.system(size: 36))
                .fontWeight(.semibold)
            Text("AI will review your code and suggest improvements.")
                .foregroundStyle(.white)
                .font(.system(size: 15))
                .fontWeight(.light)
        }
    }
    
    private var languageChangeView: some View {
        HStack(alignment: .firstTextBaseline) {
            HStack(spacing: 15) {
                Image(viewModel.selectedLanguage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                Text(viewModel.selectedLanguage)
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Change")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "#B794F4"))
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.lightGray), lineWidth: 0.8)
                    )
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.lightText).opacity(0.25))
                .stroke(Color(.lightGray), lineWidth: 0.8)
        )
    }
    
    private var easyMenu: some View {
        HStack {
            ForEach(0..<easyIcon.count, id: \.self) { index in
                
                QuickButton(index: index)
                
                if index != easyIcon.count - 1 {
                    Text("|")
                        .foregroundStyle(Color(.lightGray).opacity(0.9))
                        .font(.system(size: 32, weight: .light))
                        .padding(.bottom, 5)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.lightGray), lineWidth: 0.8)
        )
    }
    
    private func QuickButton(index: Int) -> some View {
        Button {
            Task {
                await viewModel.performAction(action: QuickActionType(rawValue: index) ?? .format)
            }
        } label: {
            Spacer()
            VStack {
                Image(systemName: easyIcon[index])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(hex: "#B794F4").opacity(0.9))
                Text(easyIconTitles[index])
                    .foregroundStyle(Color(hex: "#B794F4").opacity(0.8))
                    .font(.system(size: 14))
            }
            Spacer()
        }
    }
    
    func removeErrorView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation {
                viewModel.shouldShowError = false
            }
        }
    }
}

struct ReviewButton: View {
    
    var shouldDisable: Bool
    var onTapAction: () -> Void
    
    var body: some View {
        Button {
            if !shouldDisable { onTapAction() }
        } label: {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                
                Text("Review")
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                Spacer()
            }
        }
        .padding()
        .background(shouldDisable ? Color(.lightGray).opacity(0.6) : Color(hex: "#6048FF")) //B794F4
        .frame(maxWidth: .infinity, maxHeight: 50)
        .cornerRadius(12)
        .shadow(
            color: shouldDisable ? .clear : Color(hex: "#9A6BFF").opacity(0.35),
            radius: 16
        )
    }
}

#Preview {
    MainCodeArea(selectedLanguage: "Python")
}


//                TextEditor(text: $text)
//                    .font(.system(size: 16, design: .monospaced))
//                    .textInputAutocapitalization(.never)
//                    .autocorrectionDisabled()
//                    .scrollClipDisabled(true)
//                    .scrollDisabled(true)
