//
//  AdMobServiceImpl.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

import Foundation
import GoogleMobileAds

/// AdMob 광고 구현체
public final class AdMobServiceImpl: AdMobService {
    public lazy var fullScreenAd: FullScreenAdRepresentable = FullScreenAdmobImpl()
    
    public func setup() async {
        await withCheckedContinuation { continuation in
            MobileAds.shared.start(completionHandler: { _ in
                continuation.resume()
            })
            Task {
                if !Task.isCancelled {
                    try? await Task.sleep(nanoseconds: 180_000_000_000)
                    continuation.resume(returning: ())
                }
            }
        }
    }
}
