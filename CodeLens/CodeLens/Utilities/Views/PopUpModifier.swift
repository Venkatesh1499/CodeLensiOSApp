import SwiftUI

struct PopUpModifier<PopUp: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var shouldEnhanceBackground: Bool
    
    let popupView: () -> PopUp
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .scaleEffect(isPresented && shouldEnhanceBackground ? 1.05 : 1)
                .blur(radius: isPresented && shouldEnhanceBackground ? 8 : 0)
                .disabled(isPresented) // to prevent taps on the background visible screen as of now we have black color so not a problem.
            
            if isPresented {
                
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                
                popupView()
                    .transition(.scale(scale: 0.9).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

extension View {
    func popup<PopUp: View>(isPresented: Binding<Bool>, shouldEnhanceBackground: Bool = true, @ViewBuilder view: @escaping () -> PopUp) -> some View {
        modifier(
            CodeLens.PopUpModifier(isPresented: isPresented, shouldEnhanceBackground: shouldEnhanceBackground, popupView: view)
        )
    }
}
