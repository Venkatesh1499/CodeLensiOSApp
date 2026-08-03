import SwiftUI

struct LanguageSelectionView: View {
    
    @StateObject var viewModel = LanguageViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                CommonBackgroundView()
                
                VStack(alignment: .leading, spacing: 10) {
                    TitleAndSubtitleView(title: "Choose Language",
                                         titleSize: 32,
                                         subtitle: "Select the primary language of your code so we can tailor the Al review experience.",
                                         subtitleSize: 15,
                                         spacing: 8)
                    .padding(.horizontal)
                    
                    SearchField(searchText: $viewModel.searchText)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .onChange(of: viewModel.searchText) {
                            viewModel.showSearchResult()
                        }
                    
                    if viewModel.languages.isEmpty {
                        LanguageSearchEmptyState(searchedText: viewModel.searchText) {
                            withAnimation {
                                viewModel.searchText = ""
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach(viewModel.languages) { language in
                                    Card(language: language)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(
                                                    viewModel.selected == language.id ? Color(hex: "#6048FF") : Color.white.opacity(0.12),
                                                    lineWidth: 1
                                                )
                                        }
                                        .overlay(alignment: .topTrailing) {
                                            if viewModel.selected == language.id {
                                                Image(systemName: "checkmark")
                                                    .font(.caption.weight(.bold))
                                                    .foregroundStyle(.white)
                                                    .frame(width: 22, height: 22)
                                                    .background(
                                                        Circle()
                                                            .fill(Color(hex: "#6048FF"))
                                                    )
                                                    .padding(5)
                                            }
                                        }
                                        .shadow(
                                            color: Color(hex: "#9A6BFF").opacity(0.45),
                                            radius: 0.5
                                        )
                                        .padding(.vertical, 3)
                                        .onTapGesture {
                                            viewModel.selected = language.id
                                            viewModel.selectedLanguage = language.name
                                        }
                                }
                            }
                            .padding(.top)
                            .padding(.horizontal)
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 60)
                        .scrollIndicators(.hidden)
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollDismissesKeyboard(.immediately)
                    }
                }
                .overlay(alignment: .bottom) {
                    if !viewModel.languages.isEmpty {
                        PrimaryButton(title: "Continue", image: "arrow.forward", shouldDisable: viewModel.selectedLanguage == "") {
                            viewModel.shouldNavigateToCodeEditor = true
                        }
                    }
                }
            }
            .logoutButton(title: "") {
                viewModel.shouldShowLogoutPreconfirmation.toggle()
            }
            .popup(isPresented: $viewModel.shouldShowLogoutPreconfirmation) {
                LogoutPreConfirmationPopUp {
                    viewModel.shouldShowLogoutPreconfirmation.toggle()
                } onTapCancel: {
                    viewModel.shouldShowLogoutPreconfirmation.toggle()
                }
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToCodeEditor) {
                MainCodeArea(selectedLanguage: viewModel.selectedLanguage)
            }
        }
        .background(Color.black)
    }
}

struct Card: View {
    var language: Language
    
    var body: some View {
        VStack {
            Image.asset(language.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 90)
            Text(language.name)
                .foregroundStyle(.white)
                .font(.system(size: 12))
                .fontWeight(.regular)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

#Preview {
    LanguageSelectionView()
}
