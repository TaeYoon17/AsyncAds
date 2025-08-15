//
//  File.swift
//  AsyncAds
//
//  Created by Greem on 8/16/25.
//

import Foundation
import GoogleMobileAds

public struct MobileAdsWrapper: MobileAdsProtocol {
    public func start() async {
        await MobileAds.shared.start()
    }
}
