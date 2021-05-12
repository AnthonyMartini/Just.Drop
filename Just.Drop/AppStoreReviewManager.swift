//
//  AppStoreReviewManager.swift
//  Just.Drop
//
//  Created by Tony Martini on 5/12/21.
//

import StoreKit

enum AppStoreReviewManager {
  static func requestReviewIfAppropriate() {
    SKStoreReviewController.requestReview()
  }
}
