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
    private var task: Task<(), Never>?
    public func setup() async {
        await withCheckedContinuation { [weak self] continuation in
            guard let self else { return }
            self.task = Task {
                try? await Task.sleep(nanoseconds: 180_000_000_000)
                if !Task.isCancelled {
                    continuation.resume(returning: ())
                }
            }
            MobileAds.shared.start(completionHandler: { [weak self] _ in
                continuation.resume()
                self?.task?.cancel()
            })
        }
    }
}
