import XCTest
import tawktomvvm

final class EndPointTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testApiEndPoint() throws {
        let endpoint = EndPoinySpy(method: .get, resourcePath: "users", parameters: ["since": "0"])
        let baseURL: URL = URL(string: "https://api.github.com/")!
        let request = URLRequest(baseURL: baseURL, endpoint: endpoint)
        XCTAssertEqual(request?.url, URL(string: "https://api.github.com/users?since=0"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class EndPoinySpy: Endpoint {
    var resourcePath: Path
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders
    var version: APIVersion
    var hostOverride: String?
    var body: Data?
    
    var path: Path {
        if case .none = self.version { return self.resourcePath }
        return "/" + self.resourcePath
    }
    
    init(method: HTTPMethod = .get,
         resourcePath: Path,
         parameters: Parameters? = nil,
         headers: HTTPHeaders = [:],
         version: APIVersion = .none,
         hostOverride: String? = nil, body: Data? = nil) {

        self.method = method
        self.resourcePath = resourcePath
        self.parameters = parameters
        self.headers = headers
        self.version = version
        self.hostOverride = hostOverride
        self.body = body
        self.headers = EndPoinySpy.generateDefaultHeaders()
    }
}

extension EndPoinySpy {
    static func generateDefaultHeaders() -> HTTPHeaders {
        let headers = HTTPHeaders()
        return headers
    }
    
    
}
