import SwiftUI

struct LogoutPreConfirmationPopUp: View {
    
    var onTapLogout: (() -> Void)
    var onTapCancel: (() -> Void)
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Icon
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.12))
                    .frame(width: 64, height: 64)
                
                Image(systemName: "power")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.red)
            }
            
            
            // Title + Message
            VStack(spacing: 8) {
                Text("Logout?")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text("Are you sure you want to logout from your account?")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            
            // Buttons
            VStack(spacing: 12) {
                
                Button {
                    AuthenticationManager.shared.logout()
                    onTapLogout()
                } label: {
                    Text("Logout")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.red)
                        )
                }
                
                
                Button {
                    onTapCancel()
                } label: {
                    Text("Cancel")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(.systemGray6))
                        )
                }
            }
        }
        .padding(24)
        .frame(maxWidth: 340)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(.white)
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 25,
                    x: 0,
                    y: 10
                )
        )
    }
}
