import SwiftUI

struct TitleAndSubtitleView: View {
    
    var title: String
    var titleSize: CGFloat
    
    var subtitle: String
    var subtitleSize: CGFloat
    
    var spacing: CGFloat = 10
    var alignment: HorizontalAlignment = .leading
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            Text(title)
                .font(.system(size: titleSize, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)

            Text(subtitle)
                .font(.system(size: subtitleSize, weight: .regular))
                .foregroundStyle(Color(hex: "#94A3B8"))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
