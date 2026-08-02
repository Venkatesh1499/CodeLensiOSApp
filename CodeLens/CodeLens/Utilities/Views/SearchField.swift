//
//  SearchField.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 02/08/26.
//

import SwiftUI

struct SearchField: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 24))
                .foregroundStyle(Color(.lightGray))
            
            TextField("",
                      text: $searchText,
                      prompt: Text("Search languages...").foregroundStyle(Color(.lightGray).opacity(0.8)))
            .foregroundStyle(.white)
                .frame(height: 50)
        }
        .padding()
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(Color(.lightGray).opacity(0.8), lineWidth: 0.8)
        )
    }
}

#Preview {
    SearchField(searchText: .constant("Python"))
}
