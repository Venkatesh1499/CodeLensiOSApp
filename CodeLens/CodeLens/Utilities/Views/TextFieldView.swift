import SwiftUI

struct TextFieldView: View {

    var image: String
    var placeHolder: String
    var isSecureTextField: Bool = false
    @State var shouldShowPassword: Bool = false
    
    @Binding var value: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.gray.opacity(0.8))
                .padding(.leading)
            
            Group {
                if isSecureTextField && shouldShowPassword == false {
                    SecureField(placeHolder, text: $value)
                        
                } else {
                    TextField(placeHolder, text: $value)
                }
            }
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(height: 22)
            .padding(.trailing)
            .padding(.leading, 5)
            .padding(.vertical)
            
            if isSecureTextField {
                Button {
                    shouldShowPassword.toggle()
                } label: {
                    Image(systemName: shouldShowPassword ? "eye" : "eye.slash")
                        .resizable()
                        .renderingMode(.template)
                        .tint(Color.gray.opacity(0.8))
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.horizontal)
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
//                .stroke draws inside the .strokeBorder draws outside
                .strokeBorder(
                    Color.gray.opacity(0.9),
                    lineWidth: 1
                )
        }
    }
}

#Preview {
    @State var v = ""
    TextFieldView(image: "lock",
                  placeHolder: "Password",
                  isSecureTextField: true,
                  value: $v)
}
