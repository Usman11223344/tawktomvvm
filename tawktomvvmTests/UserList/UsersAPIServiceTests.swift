import XCTest
import tawktomvvm

final class UsersAPIServiceTests: XCTestCase {
    
    var sut: UsersAPIServiceSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UsersAPIServiceSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testGetUser() async throws {
        let result = await sut.getUser(page: 0)
        XCTAssertTrue(sut.isGetUserCalled, "When get user called")
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

class UsersAPIServiceSpy: UsersAPIServiceProtocol {
    
    var isGetUserCalled: Bool = false
    
    func getUser(page: Int) async -> tawktomvvm.Result<[tawktomvvm.User]> {
        isGetUserCalled = true
        return .success([])
    }
    
    
}
