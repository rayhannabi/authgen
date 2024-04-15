//
//  DefaultIconView.swift
//
//
//  Created by Md. Rayhan Nabi on 28/3/24.
//

import SwiftUI

public struct DefaultIconView: View {
  let color: Color

  public init(color: Color) {
    self.color = color
  }

  public var body: some View {
    GeometryReader { geometry in
      Circle()
        .fill(color)
        .overlay {
          Image.key
            .resizable()
            .scaledToFit()
            .foregroundStyle(.white)
            .frame(width: geometry.size.width * 0.6)
        }
    }
  }
}

#if DEBUG
#Preview {
  DefaultIconView(color: .red)
    .frame(width: 32, height: 32)
}
#endif
