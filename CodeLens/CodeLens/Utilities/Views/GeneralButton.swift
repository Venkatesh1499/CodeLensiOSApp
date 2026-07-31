//
//  GeneralButton.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 24/07/26.
//

import SwiftUI

struct GeneralButton: View {
    
    var title: String
    var color: String = "#7C3AED"
    var onTapAction: (() -> Void)
    
    var body: some View {
        Button {
            onTapAction()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .padding()
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: color))
            )
        }
    }
}
