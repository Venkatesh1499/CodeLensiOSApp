import SwiftUI

struct ImprovedCodeView: View {
    
    @State var code: String = """
def python():\n     return a/b
"""
    @State var shouldSelectAll: Bool = false
    var language: String = ""
    
    var body: some View {
        ZStack {
            //            LinearGradient(colors: [
            //                Color(hex: "#090F15"),
            //                Color(hex: "111827"),
            //                Color(hex: "#141FB2F") //141B2F
            //            ], startPoint: .topLeading,
            //                           endPoint: .bottomTrailing)
            //111827 //151A28
            Color(hex: "#111827").opacity(0.92)
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 0) {
                HStack {
                    Image("Python")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.vertical, 8)
                        .padding(.leading)
                    
                    Text("Python")
                        .font(.system(size: 16))
                        .foregroundStyle(Color(.lightGray))
                        .padding(8)
                    
                    Spacer()
                    
                    Image(systemName: "document.on.document")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(.lightGray))
                        .padding(.trailing)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            UIPasteboard.general.string = code
                            print("UIPasteboard.general.string", UIPasteboard.general.string)
                        }
                }
                .background(
                    Color(hex: "#090F15"),
                    in: UnevenRoundedRectangle(topLeadingRadius: 16,
                                               bottomLeadingRadius: 0,
                                               bottomTrailingRadius: 0,
                                               topTrailingRadius: 16)
                )
                
                codeEditorView(with: $code)
                    .background(
                        Color(hex: "#1E1E1E"),
                        in:
                        UnevenRoundedRectangle(topLeadingRadius: 0,
                                              bottomLeadingRadius: 16,
                                              bottomTrailingRadius: 16,
                                              topTrailingRadius: 0)
                    )
            }
            .padding()
        }
    }
    
    // This is the main code editor part
    private func codeEditorView(with code: Binding<String>) -> some View {
        let array = code.wrappedValue.split(separator: "\n", omittingEmptySubsequences: false)
        return ScrollView {
            HStack {
                VStack {
                    ForEach(0..<array.count, id: \.self) { num in
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(num + 1) |")
                                .foregroundStyle(Color(hex: "#858585"))
                                .font(.system(size: 16, weight: .regular, design: .monospaced))
                                .frame(maxWidth: 50, alignment: .trailing)
                        }
                    }
                }
                CodeEditor(text: code,
                           shouldSelectAll: $shouldSelectAll,
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
    ImprovedCodeView()
}
