//
//  ToastView.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 28/07/26.
//

import SwiftUI

struct ToastView: View {
    
    var message: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(message)
                .font(.system(size: 16, design: .rounded))
                .foregroundStyle(.white)
                .padding()
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.65))
        )
        .padding()
    }
}

struct ToasTViewModifier: ViewModifier {
    
    var message: String
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                VStack {
                    Spacer()
                    
                    ToastView(message: message)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .animation(.easeInOut, value: isShowing)
            }
        }
    }
}

extension View {
    func toastModifier(message: String, isShowing: Binding<Bool>) -> some View {
        modifier(ToasTViewModifier(message: message, isShowing: isShowing))
    }
}

#Preview {
    ToastView(message: "Copied")
}
