//
//  SplashView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import SwiftUI

struct SplashView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height - 1400

    var body: some View {

        ZStack {
            Spacer()
            HStack {
                Spacer()
                Image("remy-with-hat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                Spacer()
            }
            .overlay(
                HStack{
                    Spacer()
                    Image("hat")
                        .offset(y: offsetY)
                        .scaleEffect(0.4)
//                        .colorInvertIfDarkMode(isDarkModeOn: isDarkModeOn)
//                        .modifier(ColorInvertModifier(isDarkModeOn: isDarkModeOn))
                        .ifDarkMode(content: { $0.colorInvert() })
                    Spacer()
                }
            )
            Spacer()
        }
        .padding()
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                offsetY = -UIScreen.main.bounds.height  //  towards the top
            }
        }
    }
   
    
}

extension View {
    @ViewBuilder
    func ifDarkMode<V>(content: (Self) -> V) -> some View where V: View {
        if UIApplication.shared.windows.first?.rootViewController?.traitCollection.userInterfaceStyle == .dark {
            content(self)
        } else {
            self
        }
    }
}





struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

