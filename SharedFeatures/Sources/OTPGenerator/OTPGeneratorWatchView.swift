//
//  OTPGeneratorWatchView.swift
//
//
//  Created by Md. Rayhan Nabi on 27/3/24.
//

import Common
import Domain
import SwiftUI

public struct OTPGeneratorWatchView: View {
  let store: StoreOf<OTPGenerator>

  private let defaultColor: Color = {
    [.red, .green, .blue, .orange, .pink, .purple, .cyan, .mint].randomElement()!
  }()

  public init(store: StoreOf<OTPGenerator>) {
    self.store = store
  }

  public var body: some View {
    ScrollView {
      VStack(spacing: 0) {
//        iconView
        issuerView
        accountView
        codeView
      }
    }
    .contentMargins(.horizontal, 8, for: .scrollContent)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        lifetimeView
      }
    }
    .onAppear {
      store.send(.startTimer)
    }
  }
}

extension OTPGeneratorWatchView {
  private var iconView: some View {
    AsyncImage(url: store.entry.iconURL) { image in
      image
        .resizable()
        .scaledToFit()
        .clipShape(.rect(cornerRadius: 12))
        .frame(width: 24, height: 24)
        .padding(8)
    } placeholder: {
      if store.entry.iconURL == nil {
        Circle()
          .fill(defaultColor.opacity(0.5))
          .overlay {
            Image(systemName: "key.fill")
              .font(.system(size: 12))
          }
          .frame(width: 24, height: 24)
          .padding(4)
      } else {
        ProgressView()
      }
    }
    .id(store.entry)
  }

  private var issuerView: some View {
    Text(store.entry.issuer ?? "")
      .bold()
      .font(.system(size: 18).leading(.tight))
      .multilineTextAlignment(.center)
      .lineLimit(1)
      .animation(nil, value: store.entry)
  }

  private var accountView: some View {
    Text(store.entry.account)
      .font(.system(size: 14).leading(.tight))
      .multilineTextAlignment(.center)
      .foregroundStyle(.secondary)
      .lineLimit(2)
      .animation(nil, value: store.entry)
  }

  private var codeView: some View {
    Text(store.otp.formatted(.oneTimePassword))
      .font(.system(size: 32, weight: .bold, design: .monospaced))
      .multilineTextAlignment(.center)
      .padding(.top, 12)
      .contentTransition(.numericText())
      .animation(.smooth, value: store.otp)
      .privacySensitive()
  }

  @ViewBuilder
  private var lifetimeView: some View {
    ZStack {
      OTPProgressView(
        value: .init(get: { store.progress }, set: { _ in }),
        configuration: .init(
          progressTint: store.isCloseToEnd ? .red : .blue,
          progressLineWidth: 4,
          lineCap: .butt
        )
      )

      Text("\(store.elapsedSeconds)")
        .font(.system(size: 12))
        .foregroundStyle(store.isCloseToEnd ? .red : .blue)
    }
    .padding(4)
  }
}

#if DEBUG
#Preview {
  NavigationStack {
    OTPGeneratorWatchView(
      store: .init(
        initialState: OTPGenerator.State(entry: Entry.mocks[1]),
        reducer: OTPGenerator.init
      )
    )
  }
}
#endif
