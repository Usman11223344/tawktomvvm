import XCTest
import tawktomvvm

final class UserDetailViewModelViewTests: XCTestCase {

    var sut: UserDetailViewModelViewSpy!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UserDetailViewModelViewSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testUpdateScreen() throws {
        sut.updateScreen()
        XCTAssertTrue(sut.isUpdateScreenCalled, "When update sceen called")
    }
    
    func testShowError() throws {
        sut.showError(error: "")
        XCTAssertTrue(sut.isShowErrorCalled, "When show error called")
    }
    
    func tesShowIndicator() throws {
        sut.showIndicator()
        XCTAssertTrue(sut.isShowIndicatorCalled, "When show indicator called")
    }
    
    func testHideIndicator() throws {
        sut.hideIndicator()
        XCTAssertTrue(sut.isHideIndicatorCalled, "When hide indicator called")
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

class UserDetailViewModelViewSpy: UserDetailViewModelViewDelegate {
    
    var isUpdateScreenCalled: Bool = false
    var isShowErrorCalled: Bool = false
    var isShowIndicatorCalled: Bool = false
    var isHideIndicatorCalled: Bool = false
    
    
    func updateScreen() {
        isUpdateScreenCalled = true
    }
    
    func showError(error: String) {
        isShowErrorCalled = true
    }
    
    func showIndicator() {
        isShowIndicatorCalled = true
    }
    
    func hideIndicator() {
        isHideIndicatorCalled = true
    }
}
