//
//  ContentView.swift
//  rive_sample_empty
//
//  Created by Tyler Nijmeh (Work) on 11/4/25.
//

import SwiftUI
import RiveRuntime

struct AnimationView: View {
    let riveViewModel = RiveViewModel(fileName: "input", fit: .layout)

    var body: some View {
        riveViewModel.view()
            .onAppear {
                riveViewModel.layoutScaleFactor = 1 / 2
                riveViewModel.riveModel?.enableAutoBind { instance in
                    
                }
            }
    }
}

#Preview {
    AnimationView()
}
