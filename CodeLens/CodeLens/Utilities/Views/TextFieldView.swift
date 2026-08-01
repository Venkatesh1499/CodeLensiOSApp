import SwiftUI

struct TextFieldView: View {

    var image: String
    var placeHolder: String
    var isSecureTextField: Bool = false
    @State var shouldShowPassword: Bool = false
    @Binding var value: String
    @Binding var isTouched: Bool
    var error: String
    
    var body: some View {
        VStack(alignment: .leading) {
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
                    .stroke(
                        !error.isEmpty && isTouched ? .red : .clear,
                        lineWidth: 1
                    )
            }
            
            if !error.isEmpty && isTouched {
                Text(error)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    TextFieldView(image: "lock",
                  placeHolder: "Password",
                  isSecureTextField: true,
                  value: .constant(""),
                  isTouched: .constant(false),
                  error: "This field is required")
}
