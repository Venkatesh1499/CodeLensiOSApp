import SwiftUI

struct PopUpModifier<PopUp: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    
    let popupView: () -> PopUp
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .scaleEffect(isPresented ? 1.05 : 1)
                .blur(radius: isPresented ? 8 : 0)
                .disabled(isPresented) // to prevent taps on the background visible screen as of now we have black color so not a problem.
//
            
            if isPresented {
//                Rectangle()
//                    .fill(.regularMaterial.opacity(0.5))
//                    .ignoresSafeArea()
                
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
    func popup<PopUp: View>(isPresented: Binding<Bool>, @ViewBuilder view: @escaping () -> PopUp) -> some View {
        modifier(
            CodeLens.PopUpModifier(isPresented: isPresented, popupView: view)
        )
    }
}
