import SwiftUI

struct CreationSuccessView: View {
    
    var onTapContinue: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Success !")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                
                Text("Your account has been created successfully")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color(hex: "#94A3B8"))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(.green.opacity(0.8))
            
            PrimaryButton(title: "Continue", image: "arrow.forward", shouldDisable: false) {
                onTapContinue()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.white)
        )
        .shadow(
            color: .black.opacity(0.3),
            radius: 0.8
        )
        .padding()
    }
}

#Preview {
    CreationSuccessView() {
        
    }
}
