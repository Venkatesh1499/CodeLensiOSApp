import SwiftUI


import SwiftUI

struct ImprovedCodeView: View {

    let code: String
    let language: String

    @State private var shouldShowToast = false

    var body: some View {
        ZStack {
            CommonBackgroundView(animationRequired: true)

            VStack(alignment: .leading, spacing: 25) {
                Spacer()
                
                TitleAndSubtitleView(title: "Improved Code",
                                     titleSize: 32,
                                     subtitle: "Review and share the improved code",
                                     subtitleSize: 18)
                    .padding(.bottom)

                VStack(spacing: 0) {
                    LanguageHeaderView(language: language, onCopy: copyCode)
                    CodePreview(code: code, language: language)
                }
                
                ShareLink(item: code) {
                    ShareButton()
                }
                .padding(.vertical)

                Spacer()
            }
            .padding()
        }
        .toastModifier(
            message: "Copied",
            isShowing: $shouldShowToast
        )
    }

    private func copyCode() {
        UIPasteboard.general.string = code
        withAnimation {
            shouldShowToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                shouldShowToast = false
            }
        }
    }
}

struct LanguageHeaderView: View {

    let language: String
    let onCopy: () -> Void

    var body: some View {
        HStack {
            Image(language)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)

            Text(language)
                .foregroundStyle(.gray)

            Spacer()

            Button(action: onCopy) {

                Image(systemName: "document.on.document")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .background {
            Color(hex:"#090F15")
        }
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius:16,
                topTrailingRadius:16
            )
        )
    }
}

struct CodePreview: View {
    
    var code: String
    var language: String
    
    private var lines: [Substring] {
        code
            .split(separator: "\n",
                   omittingEmptySubsequences: false)
    }
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(0..<lines.count, id: \.self) { num in
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(num + 1) ")
                                .foregroundStyle(Color(hex: "#858585"))
                                .font(.system(size: 16, weight: .regular, design: .monospaced))
                                .frame(maxWidth: 50, alignment: .trailing)
                        }
                    }
                }
                CodeEditor(text: .constant(code),
                           shouldSelectAll: .constant(false),
                           language: language,
                           isEditable: false)
            }
            .padding(.bottom, 15)
        }
        .background(Color(hex: "#1E1E1E"))
        .frame(maxHeight: 400)
        .cornerRadius(12)
    }
}

struct ShareButton: View {
        
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
            
            Text("Share")
                .foregroundStyle(.white)
                .font(.system(size: 24))
                .fontWeight(.medium)
            Spacer()
        }
        .padding()
        .background(Color(hex: "#7C3AED")) //B794F4
        .frame(maxWidth: .infinity, maxHeight: 50)
        .cornerRadius(12)
        .shadow(
            color: Color(hex: "#9A6BFF").opacity(0.35),
            radius: 16
        )
    }
}

#Preview {
    ImprovedCodeView(code: "", language: "Python")
}
