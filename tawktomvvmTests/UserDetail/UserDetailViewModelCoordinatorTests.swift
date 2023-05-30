import XCTest
import tawktomvvm

final class UserDetailViewModelCoordinatorTests: XCTestCase {
    
    var sut: UserDetailViewModelCoordinatorSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UserDetailViewModelCoordinatorSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testUpdateUserWithNotes() throws {
        sut.updateUserWithNote(note: "", forUser: .init())
        XCTAssertTrue(sut.isUpdateUserWithNote, "When update user note")
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

class UserDetailViewModelCoordinatorSpy: UserDetailViewModelCoordinatorDelegate {
    
    var isUpdateUserWithNote = false
    
    func updateUserWithNote(note: String, forUser: tawktomvvm.User) {
        isUpdateUserWithNote = true
    }
}
