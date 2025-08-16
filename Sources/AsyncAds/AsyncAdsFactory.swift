//
//  AsyncAdsFactory.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

import Foundation

public enum AsyncAdsFactory {
    /// AdMob 서비스를 제공
    public static func makeAdMobService() -> AdMobService {
        AdMobServiceImpl(mobileAds: MobileAdsWrapper())
    }
}
