//
//  ContentView.swift
//  Fireworks
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject var particleSystem = ParticlesSystem()

    @State private var showControls = false

    var body: some View {
        VStack {
            EmitterView(particleSystem: particleSystem)
                .ignoresSafeArea()
                .background(.black)
                .onTapGesture {
                    withAnimation {
                        showControls.toggle()
                    }
                }
            if showControls {
                ControlsView(particleSystem: particleSystem)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
