//
//  PriamryButtonWithImage.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 24/07/26.
//
import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var imageName: String
    var onTapAction: (() -> Void)
    
    var body: some View {
        Button {
            onTapAction()
            print("\(title) TAPPED")
        } label: {
            HStack {
                Spacer()
                
                Text("title")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 50)
                
                Spacer()
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .padding()
            }
            .background(Color(hex: "#6048FF"))
            .frame(maxWidth: .infinity, maxHeight: 50)
            .cornerRadius(16)
            .shadow(
                color: Color(hex: "#9A6BFF").opacity(0.35),
                radius: 16
            )
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 0)
        }
    }
}
