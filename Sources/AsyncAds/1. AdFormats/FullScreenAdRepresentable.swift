//
//  FullScreenAdRepresentable.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

import Foundation

public protocol FullScreenAdRepresentable {
    
    /// 광고를 보여줄 때의 이벤트들을 방출하는 객체
    var adProcessStream: AsyncStream<FullScreenAdEffectType>! { get }
    
    /// 광고 유닛 ID를 받음
    func setADUnitID(_ id:String)
    
    /// 광고를 서버에서 데이터를 받아오는 행위
    func loadAd() async throws
    
    /// 광고를 보여주는 행위
    func showAd() async throws
    
}
