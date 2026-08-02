//
//  LanguageSearchEmptyState.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 03/08/26.
//

import SwiftUI

struct LanguageSearchEmptyState: View {
    
    var searchedText: String
    var onTapAction: () -> Void
    
    var body: some View {
        VStack(spacing: 18) {
            Spacer()
            
            Image(systemName: "apple.terminal")
                .font(.system(size: 42))
                .foregroundStyle(Color(hex: "#7C3AED"))
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(.red)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color(.lightGray).opacity(0.7), lineWidth: 0.7)
                )
            
            VStack(spacing: 10) {
                Text("No matches found")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                
                Text("We couldn't find any results for '\(searchedText)'. Try searching for a different language")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color(hex: "#94A3B8"))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Button {
                onTapAction()
            } label: {
                Text("Clear filter")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(8)
                    .frame(width: 150, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(Color(.lightGray).opacity(0.8), lineWidth: 0.8)
                            .fill(.ultraThinMaterial.opacity(0.3))
                    )
            }
            
            Spacer()
        }
    }
}

#Preview {
    LanguageSearchEmptyState(searchedText: "Ollama") {
        
    }
}
