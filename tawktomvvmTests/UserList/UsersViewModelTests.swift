import XCTest
import tawktomvvm

final class UsersViewModelTests: XCTestCase {
    
    var sut: UsersViewModelSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UsersViewModelSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testUsersViewModel() throws {
        sut.nextPage()
        sut.refresh()
        _ = sut.numberOfItems()
        _ = sut.itemFor(row: 0)
        sut.start()
        sut.searchFor(text: "")
        sut.enableSearch()
        sut.clearSearch()
        sut.didSelectRow(0, from: .init())

        XCTAssertTrue(sut.isNextPageCalled, "when next page called")
        XCTAssertTrue(sut.isRefreshCalled, "when refresh called")
        XCTAssertTrue(sut.isNumberOfItemsCalled, "when number of items called")
        XCTAssertTrue(sut.isItemForRowCalled, "when item for row called")
        XCTAssertTrue(sut.isStartCalled, "when start called")
        XCTAssertTrue(sut.isSearchForCalled, "when search for text called")
        XCTAssertTrue(sut.isEnableSearchCalled, "when enable search called")
        XCTAssertTrue(sut.isClearlyCalled, "when clear search called")
        XCTAssertTrue(sut.isDidSelectRowCalled, "when did select row called")
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

class UsersViewModelSpy: UsersViewModelType {
    var viewDelegate: tawktomvvm.UsersViewModelViewDelegate?
    var page: Int = 0
    var isSearching: Bool = false
    var isCalling: Bool = false
    var users: [User] = []
    var searchUsers: [User] = []
    
    var isNextPageCalled: Bool = false
    var isRefreshCalled: Bool = false
    var isNumberOfItemsCalled: Bool = false
    var isItemForRowCalled: Bool = false
    var isSearchForCalled: Bool = false
    var isEnableSearchCalled: Bool = false
    var isClearlyCalled: Bool = false
    var isDidSelectRowCalled: Bool = false
    var isStartCalled: Bool = false
   

    
    func nextPage() {
        isNextPageCalled = true
    }
    
    func refresh() {
        isRefreshCalled = true
    }
    
    func numberOfItems() -> Int {
        isNumberOfItemsCalled = true
        return users.count
    }
    
    func itemFor(row: Int) -> tawktomvvm.User {
        isItemForRowCalled = true
        return .init()
    }
    
    func start() {
        isStartCalled = true
    }
    
    func searchFor(text: String) {
        isSearchForCalled = true
    }
    
    func enableSearch() {
        isEnableSearchCalled = true
        
    }
    
    func clearSearch() {
        isClearlyCalled = true
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        isDidSelectRowCalled = true
    }
    
    
}
