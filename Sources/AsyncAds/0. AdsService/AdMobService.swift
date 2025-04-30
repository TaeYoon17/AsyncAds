//
//  AdMobService.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

/// AdMob에 맞는 서비스
public protocol AdMobService {
    /// 전체 화면을 띄우기 위한 프로퍼티
    var fullScreenAd: FullScreenAdRepresentable { get }
    
    /// AdMob 광고 ID 로드를 위한 메서드
    func setup() async
}




