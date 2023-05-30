import XCTest
import tawktomvvm

final class UserCoordinatorTests: XCTestCase {
    
    var sut: UserCoordinatorSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UserCoordinatorSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testUserCoordinatorStart() throws {
        sut.start()
        XCTAssertTrue(sut.isStartCalled, "When userscorrdinator start")
        
    }
    
    func testShowUserDetailViewConroller() throws {
        sut.showUserDetailViewConroller(from: .init(), detail: .init())
        XCTAssertTrue(sut.isShowDetailCalled, "When userdetailviewcontroller show")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class UserCoordinatorSpy: UsersCoordinatorProtocol {
    
    var isStartCalled: Bool = false
    var isShowDetailCalled: Bool = false
    
    func start() {
        isStartCalled = true
    }
    
    func showUserDetailViewConroller(from: UIViewController, detail: tawktomvvm.User) {
        isShowDetailCalled = true
    }
    
    
}
