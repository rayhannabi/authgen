//
//  WatchHomeEntryView.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import Domain
import SwiftUI

struct WatchHomeEntryView: View {
  var entry: Entry

  let defaultColor = [Color.red, .green, .blue, .orange, .pink, .purple, .cyan, .mint]
    .randomElement()!

  var body: some View {
    AsyncImage(url: entry.iconURL) { image in
      contentView(issuer: entry.issuer, account: entry.account) {
        image
          .resizable()
          .scaledToFit()
          .clipShape(.rect(cornerRadius: 2))
          .padding(2)
          .frame(width: 24, height: 24)
      }
    } placeholder: {
      contentView(issuer: entry.issuer, account: entry.account) {
        Circle()
          .fill(defaultColor.opacity(0.5))
          .overlay {
            Image(systemName: "key.fill")
              .font(.system(size: 8))
          }
          .padding(2)
          .frame(width: 24, height: 24)
      }
    }
  }
}

extension WatchHomeEntryView {
  typealias Action = (Entry) -> Void

  func contentView(issuer: String?, account: String, image: () -> some View) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        image()
        Text(issuer ?? "N/A")
          .lineLimit(1)
        Spacer()
      }
      Text(account)
        .font(.caption2)
        .foregroundStyle(.secondary)
        .lineLimit(1)
    }
  }
}

#if DEBUG
#Preview {
  Group {
    WatchHomeEntryView(entry: Entry.mocks[1])
    WatchHomeEntryView(entry: Entry.mocks[8])
  }
}
#endif
