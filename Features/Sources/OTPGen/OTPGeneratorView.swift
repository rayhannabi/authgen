//
//  OTPGeneratorView.swift
//
//
//  Created by Rayhan Nabi on 21/2/24.
//

import Common
import Domain
import SwiftUI

public struct OTPGeneratorView: View {
  let store: StoreOf<OTPGenerator>
  private let defaultColor: Color = {
    [.red, .green, .blue, .orange, .pink, .purple, .cyan, .mint].randomElement()!
  }()

  public init(store: StoreOf<OTPGenerator>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: 2) {
      if !store.isCollapsed {
        Group {
          iconView
          issuerView
          accountView
          codeView
        }
        .shadow(color: .primary.opacity(0.3), radius: 16)

        Divider()

        HStack {
          lifetimeView
          Spacer()
          OTPClipboardButton(value: store.otp)
        }
        .padding(.vertical)
      }
    }
    .padding(.horizontal)
    .task {
      await store.send(.startTimer).finish()
    }
  }
}

extension OTPGeneratorView {
  private var iconView: some View {
    AsyncImage(url: store.entry.iconURL) { image in
      image
        .resizable()
        .scaledToFit()
        .clipShape(.rect(cornerRadius: 12))
        .padding(8)
    } placeholder: {
      if store.entry.iconURL == nil {
        Circle()
          .fill(defaultColor.opacity(0.5))
          .overlay {
            Image(systemName: "key.fill")
              .font(.title)
          }
          .padding(4)
      } else {
        ProgressView()
      }
    }
    .frame(width: 72, height: 72)
    .id(store.entry)
  }

  private var issuerView: some View {
    Text(store.entry.issuer ?? " ")
      .bold()
      .font(.title2)
      .tracking(0.5)
      .animation(nil, value: store.entry)
  }

  private var accountView: some View {
    Text(store.entry.account)
      .bold(store.entry.issuer == nil)
      .font(.body)
      .tracking(0.5)
      .multilineTextAlignment(.center)
      .foregroundStyle(store.entry.issuer == nil ? .primary : .secondary)
      .animation(nil, value: store.entry)
  }

  private var codeView: some View {
    Text(store.otp.formatted(.oneTimePassword))
      .tracking(8.0)
      .font(.system(size: 44, weight: .bold, design: .monospaced))
      .multilineTextAlignment(.center)
      .padding(.vertical, 12)
      .contentTransition(.numericText())
      .animation(.smooth, value: store.otp)
  }

  @ViewBuilder
  private var lifetimeView: some View {
    let width = 16.0
    HStack(spacing: width) {
      OTPProgressView(
        value: .init(get: { store.progress }, set: { _ in }),
        configuration: .init(
          progressTint: store.isCloseToEnd ? .red : .accentColor,
          progressLineWidth: width,
          lineCap: .butt
        )
      )
      .frame(width: width)
      .padding(width / 2)

      Text("^[\(store.elapsedSeconds) \("second")](inflect: true)")
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
  }
}

#if DEBUG
  #Preview {
    OTPGeneratorView(
      store: .init(
        initialState: OTPGenerator.State(entry: Entry.mocks[0]),
        reducer: OTPGenerator.init
      )
    )
  }
#endif
