## AsyncAds

> 광고 모듈을 Swift Async 문법에 맞게 사용하기 위한 Wrapper Module


### 기본 구성
1. iOS 14 이상 버전만 지원한다.
2. 이 모듈은 Google AdMob 모듈을 Import 한다.
이 모듈을 사용하는 메인 프로젝트는 AdMob의 기본 구성을 따라서 설정해야한다.<br>
- AdMob 공식 문서: https://developers.google.com/admob/ios/download?hl=ko<br>
- AdMob Info.Plist 구성

```swift
<!-- Sample AdMob App ID: ca-app-pub-3940256099942544~1458002511 -->
<key>GADApplicationIdentifier</key>
<string>ADMOB_APP_ID</string>
```

### 간단 사용법

✅ 현재는 AdMob 인스턴스만 지원함

1. enum Factory를 통해 인스턴스 가져오기

2. AdMobService에 **setup** 메서드로 AdMob 초기화하기

3. 사용할 광고 형태에 맞는 프로퍼티에 맞게 사용하기
> 광고 형태
- fullScreenAd: 완전히 스크린을 가리는 광고

### 광고 띄우고 사용하기

> 주요 메서드 및 프로퍼티
1. setAdUnitID(id) - 광고 유닛 고유 ID를 가져옴
2. loadAd() - 광고를 로드함, 올바른 광고 유닛 ID가 없으면 오류 발생
3. showAd() - 광고를 보여줌, 미리 load 하지 않으면 오류 발생
4. adProcessStream - showAd() 호출 이후, 광고를 화면에 보여준 상태에 따른 이벤트 값을 반환함

> adProcessStream 적용 예시
```swift
for await effectType in adService.fullScreenAd.adProcessStream {
  switch effectType {
      case .willPresent:
        ...
      case .willDismiss:
        ...
      case .didDismiss:
        ...
      case .failed(_):
        ...
      default:
        ...
    }
}
```
