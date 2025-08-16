import Testing
import AsyncAds

actor MobileAdsMock: MobileAdsProtocol {
    private let waitNanaoSeconds: Int
    enum Result {
        case timeOut
        case success
    }
    var result: Result = .timeOut
    init(waitNanoSeconds: Int = 100_000_000) {
        self.waitNanaoSeconds = waitNanoSeconds
    }
    func start() async {
        try? await Task.sleep(nanoseconds: UInt64(waitNanaoSeconds))
        if Task.isCancelled {
            return
        }
        self.result = .success
    }
}

struct AdMobServiceImplTests {
    @Test func setupSuccessTest() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        /// Given - 100_000_000_000 동안 작업을 실행하는 Mock 구성
        let mock = MobileAdsMock()
        let sut = AdMobServiceImpl(mobileAds: mock)
        /// When
        await sut.setup()
        /// Then
        #expect(await mock.result == .success)
    }
    @Test func setUpFailedTest() async throws {
        /// Given
        let mock = MobileAdsMock(waitNanoSeconds: 200_000_000)
        let sut = AdMobServiceImpl(mobileAds: mock, sleepTime: 180_000)
        /// When
        await sut.setup()
        /// Then
        print(await mock.result)
        #expect(await mock.result == .timeOut)
    }
    
    @Test("Many setUp")
    func manySetUpTest() async throws {
        /// Given
        let mock = MobileAdsMock(waitNanoSeconds: 100_000_000)
        let sut = AdMobServiceImpl(mobileAds: mock)
        /// When
        await sut.setup()
        await sut.setup()
        await sut.setup()
        /// Then
        #expect(await mock.result == .success)
    }
}
