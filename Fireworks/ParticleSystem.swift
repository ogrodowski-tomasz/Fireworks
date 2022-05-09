//
//  ParticleSystem.swift
//  Fireworks
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

class ParticlesSystem: ObservableObject {

    let colors: [Color] = [.red, .blue, .orange, .yellow, .green]
    let image = Image("bokeh")
    var particles = Set<Particle>()
    var lastUpdate = Date()
    var lastCreationDate = Date()

    @Published var birthRate = 10.0 // Number of particles created in a second (by default)
    @Published var lifetime = 500.0 // How long should 1 particle live?
    @Published var lifetimeRange = 25.0 // Some of them live longer, some shorter.

    @Published var xPosition = 50.0
    @Published var yPosition = 0.0
    @Published var xPositionRange = 100.0
    @Published var yPositionRange = 0.0

    @Published var angle = 90.0
    @Published var angleRange = 5.0

    @Published var speed = 50.0
    @Published var speedRange = 25.0

    @Published var opacity = 50.0
    @Published var opacityRange = 50.0
    @Published var opacitySpeed = -10.0

    @Published var scale = 100.0
    @Published var scaleRange = 50.0
    @Published var scaleSpeed = 10.0 // Gets bigger on the bottom of screen

    @Published var rotation = 0.0
    @Published var rotationRange = 0.0
    @Published var rotationSpeed = 0.0

    @Published var enableBlending = false

    func update(date: Date) {
        let elapsedTime = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970 // how much time passed since last update
        lastUpdate = date

        // Movement, scaling and opacity change
        for particle in particles {
            if particle.deathDate < date {
                particles.remove(particle)
                continue
            }
            particle.x += cos(particle.angle) * particle.speed * elapsedTime / 100 // Divide by 100 becuase without that it would be too quick
            particle.y += sin(particle.angle) * particle.speed * elapsedTime / 100

            particle.scale += scaleSpeed * elapsedTime / 50
            particle.opacity += opacitySpeed * elapsedTime / 50
            particle.rotation += rotationSpeed * elapsedTime
        }
        let birthSpeed = 1 / birthRate // To create items regulary, not every one of them at once
        let elapsedSinceCreation = date.timeIntervalSince1970 - lastCreationDate.timeIntervalSince1970
        let amountToCreate = Int(elapsedSinceCreation / birthSpeed) // Making WHOLE number ex: 2, not 2.4

        for _ in 0..<amountToCreate {
            particles.insert(createParticle())
            lastCreationDate = date
        }
    }

    private func createParticle() -> Particle {
        let angleDegrees = angle + Double.random(in: -angleRange/2...angleRange/2)
        let angleRadians = angleDegrees * .pi / 180

        return Particle(
            x: xPosition/100 + Double.random(in: -xPositionRange/200...xPositionRange/200), // /200 == /(2*100)
            y: yPosition/100 + Double.random(in: -yPositionRange/200...yPositionRange/200),
            angle: angleRadians,
            speed: speed + Double.random(in: -speedRange/2...speedRange/2),
            scale: scale / 100 + Double.random(in: -scaleRange/200...speedRange/200), // dividing because we want the percentage representation
            opacity: opacity / 100 + Double.random(in: -opacityRange/200...opacityRange/200),
            deathDate: Date() + lifetime / 100 + Double.random(in: -lifetimeRange/200...lifetimeRange/200),
            rotation: rotation + Double.random(in: -rotationRange/2...rotationRange/2),
            color: colors.randomElement() ?? .white
        )
    }
}
