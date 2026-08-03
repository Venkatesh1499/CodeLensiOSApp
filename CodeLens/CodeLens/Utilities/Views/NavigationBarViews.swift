import SwiftUI

struct NavigationBarViews: ViewModifier {
    
    var title: String
    var onTapAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        NavigationStack {
            content
            
                .navigationTitle(title)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            onTapAction?()
                        } label: {
                            Image(systemName: "power")
                                .foregroundStyle(.red).opacity(0.8)
                        }
                    }
                }
        }
    }
}

extension View {
    
    func logoutButton(title: String, action: (() -> Void)?) -> some View {
        modifier(NavigationBarViews(title: title, onTapAction: action))
    }
}

