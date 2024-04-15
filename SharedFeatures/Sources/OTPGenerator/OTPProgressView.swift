// 
//  OTPProgressView.swift
//  
//
//  Created by Rayhan Nabi on 22/2/24.
//

import SwiftUI

public struct OTPProgressView: View {
  @Binding private var progress: Double
  @State private var internalProgress: Double
  private var configuration: Configuration

  public init(value: Binding<Double>, configuration: Configuration = .init()) {
    _progress = value
    _internalProgress = .init(initialValue: value.wrappedValue)
    self.configuration = configuration
  }

  public var body: some View {
    ZStack {
      Circle()
        .stroke(configuration.trackTint, lineWidth: configuration.trackLineWidth)

      Circle()
        .trim(from: 0, to: internalProgress)
        .stroke(
          configuration.progressTint,
          style: StrokeStyle(
            lineWidth: configuration.progressLineWidth,
            lineCap: configuration.lineCap
          )
        )
        .rotationEffect(.degrees(-90))
    }
    .onChange(of: progress) {
      withAnimation(progress == 1 ? nil : .linear(duration: 1)) {
        internalProgress = progress
      }
    }
  }

  public struct Configuration {
    let progressTint: Color
    let trackTint: Color
    let progressLineWidth: CGFloat
    let trackLineWidth: CGFloat
    let lineCap: CGLineCap

    public init(
      progressTint: Color = .accentColor,
      trackTint: Color? = nil,
      progressLineWidth: CGFloat = 8,
      trackLineWidth: CGFloat? = nil,
      lineCap: CGLineCap = .round
    ) {
      self.progressTint = progressTint
      self.trackTint = trackTint ?? progressTint.opacity(0.1)
      self.progressLineWidth = progressLineWidth
      self.trackLineWidth = trackLineWidth ?? progressLineWidth
      self.lineCap = lineCap
    }
  }
}
