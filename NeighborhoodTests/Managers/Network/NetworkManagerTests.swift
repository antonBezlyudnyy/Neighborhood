//
//  NetworkManagerTests.swift
//  NeighborhoodTests
//
//  Created by Anton Bezlyudnyy on 30.09.2024.
//

import XCTest
@testable import Neighborhood

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
        url = URL(string: "https://api.byteboard.dev/data/places")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSession.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        networkManager = nil
        super.tearDown()
    }
    
    
    func testMakeRequestSuccess() async throws {
        let place = Place(id: "1",
                          name: "Sample Place",
                          address: "123 Street",
                          stars: 5, reviews: 100,
                          price: "200$",
                          description: "A lovely place",
                          imageURL: URL(string:"https://example.com/image.jpg"))
        
        let expectedPlacesResult = PlaceResult(places: [place])
        
        
        do {
            let jsonData = try JSONEncoder().encode(expectedPlacesResult)
            MockURLSession.loadingHandler = {
                let response = HTTPURLResponse(url: self.url,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
                return (response!, jsonData)
            }
        } catch {
            XCTFail("Can't encode the data")
        }
        
        let result: PlaceResult? = try await networkManager.makeRequest(
            session: session,
            url: url,
            responseType: PlaceResult.self
        )
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.places.count, expectedPlacesResult.places.count)
        XCTAssertEqual(result?.places.first?.id, expectedPlacesResult.places.first?.id)
    }
    
    func testMakeRequestInvalidStatusCode() async {
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            let _ = try await networkManager.makeRequest(
                session: session,
                url: url,
                responseType: PlaceResult.self
            )
            XCTFail("Expected to throw, but did not throw")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
    
    
    func testMakeRequestNoData() async throws {
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        let result: PlaceResult? = try await networkManager.makeRequest(
            session: session,
            url: url,
            method: .GET,
            responseType: PlaceResult.self
        )
        
        XCTAssertNil(result)
    }
    
    func testMakeRequestInvalidData() async {
        let invalidData = "Invalid Data".data(using: .utf8)!
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, invalidData)
        }
        
        do {
            let _ = try await networkManager.makeRequest(
                session: session,
                url: url,
                responseType: PlaceResult.self
            )
            XCTFail("Expected to throw, but did not throw")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}
