//
//  AdMobService.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

public protocol AdMobService {
    var fullScreenAd: FullScreenAdRepresentable { get }
    
    func setup() async
}




