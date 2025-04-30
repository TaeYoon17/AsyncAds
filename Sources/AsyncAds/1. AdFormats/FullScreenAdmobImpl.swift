//
//  FullScreenAdmobImpl.swift
//  AsyncAds
//
//  Created by Greem on 4/29/25.
//

import Foundation
import GoogleMobileAds

public final class FullScreenAdmobImpl: NSObject, FullScreenAdRepresentable, FullScreenContentDelegate {
    
    private var interstitialAd: InterstitialAd?
    
    private(set) public var adProcessStream: AsyncStream<FullScreenAdEffectType>!
    private var adStreamContinuation: AsyncStream<FullScreenAdEffectType>.Continuation!
    private var adUniID = ""
    
    override init() {
        super.init()
        self.adProcessStream = AsyncStream { continuation in
            self.adStreamContinuation = continuation
        }
    }
    
    public func setADUnitID(_ id: String) {
        self.adUniID = id
    }
    
    public func loadAd() async throws {
        if adUniID.isEmpty { throw AdErrorType.notLoadedAd }
        interstitialAd = try await InterstitialAd
            .load(
                with: adUniID,
                request: Request()
            )
            interstitialAd?.fullScreenContentDelegate = self
    }
    
    @MainActor public func showAd() async throws {
        guard let interstitialAd = interstitialAd else { throw AdErrorType.notLoadedAd }
        await MainActor.run {
            interstitialAd.present(from: nil)
        }
    }
    
    
}

extension FullScreenAdmobImpl {
    
    public func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        self.adStreamContinuation.yield(.adStart)
    }
    
    public func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        self.adStreamContinuation.yield(.adLinkClicked)
    }
    
    public func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error ) {
        interstitialAd = nil
        self.adStreamContinuation.yield(.failed(error))
    }
    
    public func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        self.adStreamContinuation.yield(.willPresent)
    }
    
    public func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        self.adStreamContinuation.yield(.willDismiss)
    }
    
    public func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        interstitialAd = nil
        self.adStreamContinuation.yield(.didDismiss)
    }
}
