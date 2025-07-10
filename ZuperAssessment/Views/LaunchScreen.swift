//
//  LaunchScreen.swift
//  ZuperAssessment
//
//  Created by Pavithran P K on 10/07/25.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var showMainApp = false
    
    var body: some View {
        Group {
            if showMainApp {
                DashBoardListView()
            } else {
                VStack {
                    Image(systemName: "wrench.and.screwdriver.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.orange).opacity(0.75)
                    
                    Text("Managing Services with Ease")
                        .font(.headline)
                        .padding(.top, 8)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showMainApp = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
