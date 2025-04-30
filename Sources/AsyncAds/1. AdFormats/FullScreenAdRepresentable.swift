//
//  FullScreenAdRepresentable.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

import Foundation

public protocol FullScreenAdRepresentable {
    var adProcessStream: AsyncStream<FullScreenAdEffectType>! { get }
    
    func setADUnitID(_ id:String)
    func loadAd() async throws
    func showAd() async throws
}
