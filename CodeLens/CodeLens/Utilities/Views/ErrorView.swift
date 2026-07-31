//
//  ErrorView.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 28/07/26.
//

import SwiftUI

struct ErrorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
//        ZStack {
//            Color.black
//                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Spacer()
                
                HStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 30))
                        .foregroundStyle(.red)
                        .padding(8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Review request failed")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color(.white).opacity(0.9))
                        
                        Text("Something went wrong. Please try again.")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.white).opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18))
                        .foregroundStyle(.red)
                        .padding(.trailing, 5)
//                    Text("Retry")
//                        .font(.system(size: 16, weight: .medium))
//                        .foregroundStyle(.red)
//                        .padding()
//                        .onTapGesture {
////                            dismiss()
//                        }
                    
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.red.opacity(0.15))
                        .stroke(.red, lineWidth: 1)
                )
                .shadow(
                    color: .red,
                    radius: 0.5
                )
            }
            .padding(.bottom, 5)
//        }
    }
}

#Preview {
    ErrorView()
}
