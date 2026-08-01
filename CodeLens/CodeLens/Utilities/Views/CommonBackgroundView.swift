//
//  CommonBackgroundView.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 02/08/26.
//
import SwiftUI

struct CommonBackgroundView: View {
    
    var animationRequired: Bool = false
    
    var body: some View {
        LinearGradient(
            colors: [
                Color(hex: "#0F172A"),
                Color(hex: "#1E293B")
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            if animationRequired {
                withAnimation {
                    ForEach([220, 300, 380], id: \.self) { size in
                        Circle()
                            .fill(.white.opacity(0.01))
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            .frame(width: CGFloat(size), height: CGFloat(size))
                    }
                    .offset(x: 180, y: -180)
                }
            }
        }
    }
}
