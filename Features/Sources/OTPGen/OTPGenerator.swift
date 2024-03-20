//
//  OTPGenerator.swift
//
//
//  Created by Rayhan Nabi on 21/2/24.
//

import Common
import Domain
import Foundation

@Reducer
public struct OTPGenerator {

  @ObservableState
  public struct State: Equatable {
    var entry: Entry
    var otp = "000000"
    var elapsedSeconds = maxSeconds
    var progress: Double = 1
    var isCollapsed = false
    var isCloseToEnd: Bool { progress <= 0.2 }

    public init(entry: Entry) {
      self.entry = entry
    }
  }

  public enum Action: Equatable {
    case startTimer
    case tick
    case toggleCollapse(Bool)
  }

  private enum CancelID: Hashable {
    case cancel
  }

  @Dependency(\.continuousClock) var clock

  public init() {}

  public var body: some ReducerOf<OTPGenerator> {
    Reduce { state, action in
      switch action {
      case .startTimer:
        return .concatenate(
          generateOTP(&state),
          runTimer(&state)
        )
      case .tick:
        guard state.elapsedSeconds == 1 else {
          state.elapsedSeconds -= 1
          return updateProgress(&state)
        }
        return .concatenate(
          reset(&state),
          generateOTP(&state)
        )

      case .toggleCollapse(let isCollapsed):
        state.isCollapsed = isCollapsed
        return .none
      }
    }
  }

  private func runTimer(_ state: inout State) -> Effect<Action> {
    .run { send in
      for await _ in clock.timer(interval: .seconds(1)) {
        await send(.tick)
      }
    }
    .cancellable(id: CancelID.cancel, cancelInFlight: true)
  }

  private func generateOTP(_ state: inout State) -> Effect<Action> {
    guard let otp = (100_000...999_999).randomElement() else { return .none }
    state.otp = "\(otp)"
    return .none
  }

  private func updateProgress(_ state: inout State) -> Effect<Action> {
    state.progress = Double(state.elapsedSeconds) / Double(maxSeconds)
    return .none
  }

  private func reset(_ state: inout State) -> Effect<Action> {
    state.elapsedSeconds = maxSeconds
    return .merge(
      .cancel(id: CancelID.cancel),
      updateProgress(&state),
      runTimer(&state)
    )
  }
}

let maxSeconds = 30
