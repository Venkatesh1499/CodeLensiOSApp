//
import SwiftUI
import Combine

struct LoadingAnimation: View {
     
    var body: some View {
        HStack(spacing: 10) {
            ProgressView()
                .controlSize(.large)
                .tint(.white.opacity(0.9))
                .progressViewStyle(.automatic)
            
                scrollingText()
        }
        .frame(maxHeight: 35)
        .clipped()
    }
}

struct scrollingText : View {
    
    private let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    @State var index = 0
    
    var body: some View {
        Text(reviewStages[index])
            .id(index)
            .font(.headline)
            .foregroundStyle(.white)
            .transition(
                .asymmetric(insertion: .move(edge: .top),
                            removal: .move(edge: .bottom))
            )
            .animation(.easeInOut(duration: 0.4), value: index)
            .frame(maxHeight: 30)
            .clipped()
            .onReceive(timer) { _ in
                withAnimation {
                    index = (index + 1) % reviewStages.count
                }
            }
    }
}

#Preview {
    LoadingAnimation()
}
