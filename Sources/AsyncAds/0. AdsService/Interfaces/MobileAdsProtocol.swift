//
//  File.swift
//  AsyncAds
//
//  Created by Greem on 8/16/25.
//

import Foundation

/// Sendable Protocol 준수... Data race에서 자유로움
public protocol MobileAdsProtocol: Sendable {
    func start() async
}
