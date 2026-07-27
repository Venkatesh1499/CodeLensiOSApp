import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var image: String
    var shouldDisable: Bool = false
    var onTapAction: (() -> Void)
    
    var body: some View {
        Button {
            onTapAction()
        } label: {
            HStack {
                Spacer()
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 50)
                
                Spacer()
                
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .padding()
            }
            .background(shouldDisable ? Color(.lightGray).opacity(0.6) : Color(hex: "#6048FF"))
            .frame(maxWidth: .infinity, maxHeight: 50)
            .cornerRadius(16)
            .shadow(
                color: shouldDisable ? .clear : Color(hex: "#9A6BFF").opacity(0.35),
                radius: 16
            )
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 0)
        }
    }
}

#Preview {
    PrimaryButton(title: "Continue", image: "arrow.forward", shouldDisable: true) {
        print("Continue tapped please proceed")
    }
}
