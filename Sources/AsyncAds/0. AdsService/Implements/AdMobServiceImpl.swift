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
    
    private let mobileAds: MobileAdsProtocol
    private let sleepTime: UInt64
    
    public init(mobileAds: MobileAdsProtocol, sleepTime: UInt64 = 180_000_000_000) {
        self.mobileAds = mobileAds
        self.sleepTime = sleepTime
    }
    
    public func setup() async {
        await withThrowingTaskGroup(of: Void.self) { [sleepTime, mobileAds] group in
            group.addTask {
                try await Task.sleep(nanoseconds: sleepTime)
            }
            group.addTask {
                await mobileAds.start()
            }
            
            try? await group.next()
            /// 하나 실행 이후 그냥 없애버림
            group.cancelAll()
            print("setUp 끝남")
        }
    }
}
