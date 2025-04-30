//
//  AsyncAdsFactory.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

import Foundation

public enum AsyncAdsFactory {
    public static func makeAdMobService() -> AdMobService {
        AdMobServiceImpl()
    }
}
