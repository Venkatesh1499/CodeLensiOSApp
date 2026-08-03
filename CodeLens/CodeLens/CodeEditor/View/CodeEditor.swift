import SwiftUI
import UIKit
import Highlightr

struct CodeEditor: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var shouldSelectAll: Bool
    @Binding var shouldHideKeyboard: Bool
    
    var language: String
    var isEditable: Bool = true
    let highlightr = Highlightr()
   
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.isEditable = isEditable
        textView.isScrollEnabled = true
        
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none

        textView.font = UIFont.monospacedSystemFont(
            ofSize: 16,
            weight: .regular
        )

        let textContainer = textView.textContainer

        // No wrapping
        textContainer.widthTracksTextView = false
        textContainer.lineBreakMode = .byClipping

        // Make the text layout extremely wide
//        textContainer.size = CGSize(
//            width: CGFloat.greatestFiniteMagnitude,
//            height: CGFloat.greatestFiniteMagnitude
//        )

        textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero

        textView.text = text
        textView.delegate = context.coordinator
        
//        DispatchQueue.main.async {
//            textView.becomeFirstResponder()
//        }

        textView.backgroundColor = UIColor(Color(hex: "#1E1E1E"))

        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        
        if shouldSelectAll {
            uiView.selectAll(self)
            shouldSelectAll.toggle()
        }
        
        if let highlighted = highlightr?.highlight(
            uiView.text,
            as: language) {
            let selectedRange = uiView.selectedRange
            
            let nsMutableAttributedString = NSMutableAttributedString(attributedString: highlighted)
            
            nsMutableAttributedString.addAttribute(.font,
                                                   value: UIFont.monospacedSystemFont(ofSize: 16, weight: .regular),
                                                   range: NSRange(location: 0, length: highlighted.length))
            
            uiView.attributedText = nsMutableAttributedString

            uiView.selectedRange = selectedRange
            
            uiView.textContainer.widthTracksTextView = false
                uiView.textContainer.lineBreakMode = .byClipping
                uiView.textContainer.size = CGSize(
                    width: CGFloat.greatestFiniteMagnitude,
                    height: CGFloat.greatestFiniteMagnitude
                )
        }
        
        if shouldHideKeyboard {
            uiView.resignFirstResponder()
        } else {
            uiView.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: CodeEditor
        
        init(_ parent: CodeEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text

//            DispatchQueue.main.async {
//                guard let selectedRange = textView.selectedTextRange else { return }
//
//                let caretRect = textView.caretRect(for: selectedRange.end)
//
//                textView.scrollRectToVisible(
//                    caretRect.insetBy(dx: -20, dy: 0),
//                    animated: false
//                )
//            }
        }
    }
}
