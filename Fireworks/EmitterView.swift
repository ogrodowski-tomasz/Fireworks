//
//  EmitterView.swift
//  Fireworks
//
//  Created by Tomasz Ogrodowski on 09/05/2022.
//

import SwiftUI

struct EmitterView: View {

    var particleSystem: ParticlesSystem // Doesn't have to watch for changes because of TimelineView

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                particleSystem.update(date: timeline.date)
                var particleImage = context.resolve(particleSystem.image)
                let baseTransform = context.transform

                if particleSystem.enableBlending {
                    context.blendMode = .plusLighter // when particles touch, they become lighter
                }

                for particle in particleSystem.particles {
                    let xPos = particle.x * size.width
                    let yPos = particle.y * size.height

                    particleImage.shading = .color(particle.color)

                    context.opacity = particle.opacity
                    context.translateBy(x: xPos, y: yPos)
                    context.scaleBy(x: particle.scale, y: particle.scale)

                    let rotationAmount = Angle(degrees: particle.rotation)
                    context.rotate(by: rotationAmount)

                    context.draw(particleImage, at: .zero) // drawing resolved (colored) image, not the original one.
                    context.transform = baseTransform
                }

            }
        }
    }
}
