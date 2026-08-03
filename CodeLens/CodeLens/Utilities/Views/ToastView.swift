import SwiftUI

struct ToastView: View {
    
    var message: String
    var isSuccess: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            
            if isSuccess {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
            }
            
            Text(message)
                .font(.system(size: isSuccess ? 20 : 16, weight: isSuccess ? .semibold : .regular, design: .rounded))
                .foregroundStyle(.white)
                .padding()
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSuccess ? Color.green.opacity(0.85) : Color.black.opacity(0.65))
        )
        .padding()
    }
}

struct ToasTViewModifier: ViewModifier {
    
    var message: String
    var isSuccess: Bool
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                VStack {
                    Spacer()
                    
                    ToastView(message: message, isSuccess: isSuccess)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .animation(.easeInOut, value: isShowing)
            }
        }
    }
}

extension View {
    func toastModifier(message: String, isSuccess: Bool = false, isShowing: Binding<Bool>) -> some View {
        modifier(ToasTViewModifier(message: message, isSuccess: isSuccess, isShowing: isShowing))
    }
}

#Preview {
    ToastView(message: "Login successfull", isSuccess: true)
}
