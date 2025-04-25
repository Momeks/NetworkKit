import XCTest
@testable import NetworkKit

final class NetworkKitTests: XCTestCase {
    
    func testFetchSinglePostSuccess() async throws {
        // Arrange
        let mockService = MockNetworkService()
        let expectedPost = Post(
            userId: 1,
            id: 2,
            title: "qui est esse",
            body: """
            est rerum tempore vitae
            sequi sint nihil reprehenderit dolor beatae ea dolores neque
            fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis
            qui aperiam non debitis possimus qui neque nisi nulla
            """
        )
        mockService.mockData = expectedPost
        let endpoint = PostsEndpoint(type: .single(id: 2))

        let post: Post = try await mockService.fetch(from: endpoint)

        XCTAssertEqual(post, expectedPost)
    }
    
    func testPostsEndpointAllPath() {
        let endpoint = PostsEndpoint(type: .all)
        
        XCTAssertEqual(endpoint.path, "posts")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.queryItems?.isEmpty, true)
        XCTAssertNil(endpoint.headers)
    }
    
    func testPostsEndpoint_SinglePostPath() {
        let endpoint = PostsEndpoint(type: .single(id: 42))
        
        XCTAssertEqual(endpoint.path, "posts/42")
    }
    
    func testPostsEndpointBaseURL() {
        let endpoint = PostsEndpoint(type: .all)
        
        XCTAssertEqual(endpoint.baseURL.absoluteString, "https://jsonplaceholder.typicode.com")
    }
    
    func testPostsEndpointHasNoBody() {
        let allEndpoint = PostsEndpoint(type: .all)
        let singleEndpoint = PostsEndpoint(type: .single(id: 1))

        XCTAssertNil(allEndpoint.body)
        XCTAssertNil(singleEndpoint.body)
    }
    
    func testPostsEndpointGeneratesValidURLRequest() {
        let endpoint = PostsEndpoint(type: .single(id: 99))
        let request = endpoint.urlRequest

        XCTAssertEqual(request?.url?.absoluteString, "https://jsonplaceholder.typicode.com/posts/99")
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertNil(request?.httpBody)
    }
}
