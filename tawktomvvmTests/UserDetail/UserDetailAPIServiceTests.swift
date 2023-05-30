import XCTest
import tawktomvvm

final class UserDetailAPIServiceTests: XCTestCase {
    
    var sut: UserDetailAPIServiceSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UserDetailAPIServiceSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testGetUserDetail() async throws {
        _ = await sut.getUserDetail(name: "")
        XCTAssertTrue(sut.isGetUserDetailCalled, "when get user detail calle")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


class UserDetailAPIServiceSpy: UserDetailAPIServiceProtocol {
    
    var isGetUserDetailCalled = false
    
    func getUserDetail(name: String) async -> tawktomvvm.Result<tawktomvvm.UserDetail> {
        isGetUserDetailCalled = true
        return Result.success(UserDetail())
        
    }
    
    
}
