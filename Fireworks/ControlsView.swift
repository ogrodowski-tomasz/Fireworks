//
//  ControlsView.swift
//  Fireworks
//
//  Created by Tomasz Ogrodowski on 09/05/2022.
//

import SwiftUI

struct ControlsView: View {

    @ObservedObject var particleSystem: ParticlesSystem

    var body: some View {
        Form {
            Section {
                Stepper("Birth rate: \(particleSystem.birthRate, specifier: "%.0f")", value: $particleSystem.birthRate, in: 1...500, step: 5) // "%.0f" : Float number with no decimal places behind

                Stepper("Lifetime: \(particleSystem.lifetime, specifier: "%g")", value: $particleSystem.lifetime, in: 25...1000, step: 25) // Float number with as few decimal numbers as needed ex 2.0 is 2.0 not 2.000000

                Stepper("Lifetime range: \(particleSystem.lifetimeRange / 100, specifier: "%g")", value: $particleSystem.lifetimeRange, in: 0...10000, step: 25)
            } header: {
                Text("Creation")
            }


            Section {
                Stepper("x: \(particleSystem.xPosition, specifier: "%g")%", value: $particleSystem.xPosition, in: -20...120, step: 5)

                Stepper("Range: \(particleSystem.xPositionRange, specifier: "%g")%", value: $particleSystem.xPositionRange, in: 1...100, step: 5)

                Stepper("y: \(particleSystem.yPosition, specifier: "%g")%", value: $particleSystem.yPosition, in: -20...120, step: 5)

                Stepper("Range: \(particleSystem.yPositionRange, specifier: "%g")%", value: $particleSystem.yPositionRange, in: 1...100, step: 5)
            } header: {
                Text("Position")
            }

            Section {
                Stepper("Base: \(particleSystem.speed, specifier: "%g")", value: $particleSystem.speed)

                Stepper("Range: \(particleSystem.speedRange, specifier: "%g")", value: $particleSystem.speedRange, in: 0...1000)
            } header: {
                Text("Speed")
            }

            Section {
                Stepper("Base: \(particleSystem.angle, specifier: "%g")°", value: $particleSystem.angle, in: 0...360, step: 5)

                Stepper("Range: \(particleSystem.angleRange, specifier: "%g")°", value: $particleSystem.angleRange, in: 0...360, step: 5)

            } header: {
                Text("Angle")
            }

            Section {
                Stepper("Base: \(particleSystem.scale, specifier: "%g")", value: $particleSystem.scale, in: 5...1000, step: 5)

                Stepper("Range: \(particleSystem.scaleRange, specifier: "%g")", value: $particleSystem.scaleRange, in: 0...1000, step: 5)

                Stepper("Speed: \(particleSystem.scaleSpeed, specifier: "%g")", value: $particleSystem.scaleSpeed, in: -100...100, step: 1)
            } header: {
                Text("Scale")
            }

            Section {
                Stepper("Base: \(particleSystem.opacity, specifier: "%g")%", value: $particleSystem.opacity, in: 5...100, step: 5)

                Stepper("Range: \(particleSystem.opacityRange, specifier: "%g")%", value: $particleSystem.opacityRange, in: 0...100, step: 5)

                Stepper("Speed: \(particleSystem.opacitySpeed, specifier: "%g")", value: $particleSystem.opacitySpeed, in: -100...100, step: 1)
            } header: {
                Text("Opacity")
            }

            Section {
                Stepper("Base: \(particleSystem.rotation, specifier: "%g")°", value: $particleSystem.rotation, in: 5...360, step: 5)

                Stepper("Range: \(particleSystem.rotationRange, specifier: "%g")°", value: $particleSystem.rotationRange, in: 0...360, step: 5)

                Stepper("Speed: \(particleSystem.rotationSpeed, specifier: "%g")", value: $particleSystem.rotationSpeed, in: -100...100, step: 1)
            } header: {
                Text("Rotation")
            }

            Toggle("Blend overlapping particles", isOn: $particleSystem.enableBlending)
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(particleSystem: ParticlesSystem())
    }
}
