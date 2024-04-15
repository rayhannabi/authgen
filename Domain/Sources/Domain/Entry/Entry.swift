//
//  Entry.swift
//
//
//  Created by Rayhan Nabi on 10/2/24.
//

import Foundation
import SwiftUI

public struct Entry: Identifiable, Equatable, Hashable {
  public let id = UUID()
  public var secret: String
  public var account: String
  public var issuer: String?
  public var iconURL: URL?
  public var color: Color

  public init(
    secret: String,
    account: String,
    issuer: String? = nil,
    iconURL: URL? = nil,
    color: Color = .accentColor
  ) {
    self.secret = secret
    self.account = account
    self.issuer = issuer
    self.iconURL = iconURL
    self.color = color
  }
}

extension Entry {
  public static var mocks: [Entry] {
    [
      .init(
        secret: UUID().uuidString,
        account: "john.appleseed@example.com",
        issuer: "Apple",
        iconURL: URL(
          string:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/1280px-Apple_logo_black.svg.png"
        ),
        color: .black
      ),
      .init(
        secret: UUID().uuidString,
        account: "johnny.appleseed@gmail.com",
        issuer: "Gmail",
        iconURL: URL(
          string:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/2048px-Google_%22G%22_logo.svg.png"
        ),
        color: .red
      ),
      .init(
        secret: UUID().uuidString,
        account: "john.appleseed@meta.com",
        issuer: "Meta",
        iconURL: URL(
          string:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Meta_Platforms_Inc._logo_%28cropped%29.svg/150px-Meta_Platforms_Inc._logo_%28cropped%29.svg.png"
        ),
        color: .blue
      ),
      .init(
        secret: UUID().uuidString,
        account: "ray@example.com",
        issuer: "Snapchat",
        iconURL: URL(
          string:
            "https://upload.wikimedia.org/wikipedia/en/thumb/c/c4/Snapchat_logo.svg/1920px-Snapchat_logo.svg.png"
        ),
        color: .yellow
      ),
      .init(
        secret: UUID().uuidString,
        account: "siera.november@example.com",
        issuer: "X",
        iconURL: URL(
          string:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/X_logo_2023.svg/1920px-X_logo_2023.svg.png"
        ),
        color: .black
      ),
      .init(
        secret: UUID().uuidString,
        account: "john.appleseed@example.com",
        issuer: "Github",
        iconURL: URL(
          string:
            "https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png"
        ),
        color: .black
      ),
      .init(
        secret: UUID().uuidString,
        account: "007@sis.gov.uk",
        issuer: "MI6",
        iconURL: URL(
          string:
            "https://static.wikia.nocookie.net/totalwar-ar/images/e/e0/MI6.png/revision/latest/scale-to-width-down/549?cb=20221127042750"
        ),
        color: .mint
      ),
      .init(
        secret: UUID().uuidString,
        account: "john.appleseed@example.com",
        issuer: "Apple",
        iconURL: URL(
          string:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Apple_Computer_Logo_rainbow.svg/1200px-Apple_Computer_Logo_rainbow.svg.png"
        ),
        color: .black
      ),
      .init(
        secret: UUID().uuidString,
        account: "john.doe@example.com",
        color: .green
      ),
      .init(
        secret: UUID().uuidString,
        account: "ray@qdot.org",
        color: .cyan
      ),
      .init(
        secret: UUID().uuidString,
        account: "ray@micron.com",
        color: .purple
      ),
    ]
  }
}
