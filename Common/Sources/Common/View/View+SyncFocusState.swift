//
//  View+SyncFocusState.swift
//
//
//  Created by Rayhan Nabi on 18/3/24.
//

import SwiftUI

extension View {
  public func syncFocusState<Value>(
    _ focusState: FocusState<Value>.Binding,
    with binding: Binding<Value>
  ) -> some View {
    self
      .onChange(of: focusState.wrappedValue) {
        binding.wrappedValue = focusState.wrappedValue
      }
      .onChange(of: binding.wrappedValue) {
        focusState.wrappedValue = binding.wrappedValue
      }
  }
}
