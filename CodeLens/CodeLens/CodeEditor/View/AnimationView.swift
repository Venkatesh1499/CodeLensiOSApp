//
//  AnimationView.swift
//  MainCodeArea
//
//  Created by Venkatesh Nimmalapudi on 22/07/26.
//
import SwiftUI

struct AnimationView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ZStack{
            Color.white.opacity(0.09)
                .ignoresSafeArea()
            
            Image(systemName: "sparkles")
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 120, height: 120)
                .rotationEffect(.degrees(animate ? 360 : 0))
                .scaleEffect(animate ? 1.6 : 0.9)
                .opacity(animate ? 1 : 0.6)
                .animation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                    value: animate
                )
                .onAppear {
                    animate.toggle()
                }
        }
    }
}

struct SplashScreenAnimation: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            Image("LaunchScreen")
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 120, height: 120)
//                .rotationEffect(.degrees(animate ? 360 : 0))
                .scaleEffect(animate ? 80 : 0.9)
//                .opacity(animate ? 1 : 0.6)
                .animation(
                    .easeInOut(duration: 1.5),
//                    .repeatForever(autoreverses: true),
                    value: animate
                )
                .onAppear {
                    animate.toggle()
                }
        }
    }
}

#Preview {
    AnimationView()
}
