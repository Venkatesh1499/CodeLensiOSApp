import SwiftUI

struct GeneralButton: View {
    
    var title: String
    var color: String = "#7C3AED"
    @Binding var isLoading: Bool
    
    var onTapAction: (() -> Void)
    
    @State var animate: Bool = false
    
    var body: some View {
        Button {
            onTapAction()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: isLoading ? 26 : 14)
                    .fill(Color(hex: color))
                if isLoading {
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .stroke(Color.white, lineWidth: 3)
                        .rotationEffect(.degrees(animate ? 360 : 0))
                        .animation(
                            .linear(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animate
                        )
                        .onAppear {
                            self.animate = true
                        }
                        .frame(width: 40, height: 40)
                } else {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .onAppear {
                            self.animate = false
                        }
                }
            }
        }
        .frame(maxWidth: isLoading ? 52 : .infinity)
    }
}


struct CircleLoadingView: View {
    @State var animate: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(hex: "#7C3AED"))
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.white, lineWidth: 3)
                .rotationEffect(.degrees(animate ? 360 : 0))
                .animation(
                    .linear(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animate
                )
                .onAppear {
                    self.animate.toggle()
                }
                .frame(width: 40, height: 40)
        }
        .frame(width: 50, height: 50)
    }
}


#Preview {
    GeneralButton(title: "Login", isLoading: .constant(true)) {
    }
}
