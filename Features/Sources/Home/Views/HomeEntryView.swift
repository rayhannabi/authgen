//
//  HomeEntryView.swift
//
//
//  Created by Rayhan Nabi on 21/2/24.
//

import Domain
import SwiftUI

struct HomeEntryView: View {
  var entry: Entry
  @Binding var searchText: String
  var tapAction: Action?
  var editAction: Action?
  var deleteAction: Action?

  let defaultColor = [Color.red, .green, .blue, .orange, .pink, .purple, .cyan, .mint]
    .randomElement()!

  var body: some View {
    Button {
      tapAction?(entry)
    } label: {
      contentView
    }
    .buttonStyle(HomeEntryButtonStyle())
    #if os(iOS)
    .contextMenu {
      Button("Edit", systemImage: "pencil") {
        editAction?(entry)
      }
      Divider()
      Button("Delete", systemImage: "trash", role: .destructive) {
        deleteAction?(entry)
      }
    }
    #endif
  }
}

extension HomeEntryView {
  typealias Action = (Entry) -> Void

  private var iconView: some View {
    AsyncImage(url: entry.iconURL) { image in
      image
        .resizable()
        .scaledToFit()
        .clipShape(.rect(cornerRadius: 6))
        .padding(8)
    } placeholder: {
      Circle()
        .fill(defaultColor.opacity(0.5))
        .overlay {
          Image(systemName: "key.fill")
        }
        .padding(4)
    }
    .frame(width: 48, height: 48)
  }

  func accountText(_ value: String, isPrimary: Bool) -> AttributedString {
    var text = AttributedString(value)
    text.foregroundColor = isPrimary ? .primary : .secondary
    text.font = isPrimary ? .headline.bold() : .subheadline
    text.tracking = isPrimary ? 0.5 : 0
    guard let range = text.range(of: searchText, options: .caseInsensitive) else { return text }
    text[range].foregroundColor = .accentColor
    return text
  }

  func issuerText(_ value: String) -> AttributedString {
    var text = AttributedString(value)
    text.foregroundColor = .primary
    text.font = .headline.bold()
    text.tracking = 0.5
    guard let range = text.range(of: searchText, options: .caseInsensitive) else { return text }
    text[range].foregroundColor = .accentColor
    return text
  }

  private var contentView: some View {
    HStack {
      iconView

      VStack(alignment: .leading, spacing: 0) {
        if let issuer = entry.issuer {
          Text(issuerText(issuer))
          Text(accountText(entry.account, isPrimary: false))
        } else {
          Text(accountText(entry.account, isPrimary: true))
        }
      }

      Spacer()
    }
    .shadow(color: .primary.opacity(0.3), radius: 16)
    .padding(.horizontal)
    .padding(.vertical, 12)
    .background(.ultraThickMaterial)
    .clipShape(.rect(cornerRadius: 16))
  }
}

struct HomeEntryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(background(for: configuration))
      .clipShape(.rect(cornerRadius: 16))
  }

  private func background(for configuration: Configuration) -> Color {
    configuration.isPressed ? .accentColor.opacity(0.3) : .clear
  }

}

#if DEBUG
#Preview {
  ScrollView {
    ForEach(Entry.mocks) {
      HomeEntryView(entry: $0, searchText: .constant(""))
    }
  }
}
#endif
