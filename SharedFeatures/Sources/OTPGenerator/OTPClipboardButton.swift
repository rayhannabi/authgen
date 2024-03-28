// 
//  OTPClipboardButton.swift
//  
//
//  Created by Rayhan Nabi on 22/2/24.
//

import SwiftUI

struct OTPClipboardButton: View {
  var value: String
  
  @State private var copied = false

  private var text: String {
    copied ? "Copied" : "Copy"
  }

  private var imageName: String {
    copied ? "checkmark" : "clipboard"
  }

  private var foreground: Color {
    copied ? .green : .secondary
  }
  
  var body: some View {
    Button {
      copyToClipboard()
    } label: {
      HStack(spacing: 4) {
        Image(systemName: imageName)
          .font(.subheadline)
          .bold()
          .foregroundStyle(foreground)
        
        Text(text)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .id(text)
      }
    }
    .buttonStyle(.plain)
    .contentTransition(.symbolEffect(.replace))
    .disabled(copied)
  }
  
  func copyToClipboard() {
    #if os(iOS)
    UIPasteboard.general.string = value
    #elseif os(macOS)
    NSPasteboard.general.declareTypes([.string], owner: nil)
    NSPasteboard.general.setString(value, forType: .string)
    #endif
    
    withAnimation(.smooth) {
      copied = true
    }
    Task {
      try await Task.sleep(for: .seconds(1))
      withAnimation(.smooth(duration: 0.3)) {
        copied = false
      }
    }
  }
}

#if DEBUG
#Preview {
  OTPClipboardButton(value: "lorem")
}
#endif
