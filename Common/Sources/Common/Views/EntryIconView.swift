//
//  EntryIconView.swift
//
//
//  Created by Md. Rayhan Nabi on 28/3/24.
//

import SwiftUI

public struct EntryIconView: View {
  let url: URL?
  let color: Color

  public init(url: URL?, color: Color) {
    self.url = url
    self.color = color
  }

  public var body: some View {
    AsyncImage(url: url) { phase in
      switch phase {
      case .empty:
        if url == nil {
          DefaultIconView(color: color)
        } else {
          ProgressView()
        }
      case .success(let image):
        image
          .resizable()
          .scaledToFit()
      case .failure:
        DefaultIconView(color: color)
      @unknown default:
        DefaultIconView(color: color)
      }
    }
  }
}

#if DEBUG
#Preview {
  Group {
    EntryIconView(
      url: URL(
        string:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/2048px-Google_%22G%22_logo.svg.png"
      ),
      color: .green
    )
    EntryIconView(
      url: nil,
      color: .blue
    )
  }
  .frame(width: 64, height: 64)
}
#endif
