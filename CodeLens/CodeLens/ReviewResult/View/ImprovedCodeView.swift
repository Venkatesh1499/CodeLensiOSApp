import SwiftUI


import SwiftUI

struct ImprovedCodeView: View {

    let code: String
    let language: String

    @State private var shouldShowToast = false

    var body: some View {
        ZStack {
            Color(hex: "#111827")
                .ignoresSafeArea()

            VStack(spacing: 20) {

                CodeHeaderView()

                LanguageHeaderView(language: language, onCopy: copyCode)
                
                CodePreview(code: code, language: language)

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

struct CodeHeaderView: View {

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "chevron.left.forwardslash.chevron.right")
                .font(.system(size: 26))
                .foregroundStyle(.white)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                }
            VStack(alignment: .leading, spacing: 6) {
                Text("Improved Code")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white)

                Text("Review and copy the improved code")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }

            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 14)
                .stroke(.white.opacity(0.3))
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
                            Text("\(num + 1) |")
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
//                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.bottom, 15)
        }
        .background(Color(hex: "#1E1E1E"))
        .frame(maxHeight: 380)
        .cornerRadius(12)
    }
}

#Preview {
    ImprovedCodeView(code: "", language: "Python")
}
