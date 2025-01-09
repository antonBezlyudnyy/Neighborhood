//
//  PlacesListViewModelSuccessTests.swift
//  NeighborhoodTests
//
//  Created by Anton Bezlyudnyy on 10/8/24.
//

import XCTest
@testable import Neighborhood

final class PlacesListViewModelSuccessTests: XCTestCase {
    private var netWorkingMock: NetworkManagerImpl!
    private var viewModel: PlaceListViewModel!
    
    override func setUp() {
        netWorkingMock = PlacesResponseSuccessMock()
        viewModel = PlaceListViewModel(networkManager: netWorkingMock)
    }
    
    override func tearDown() {
        netWorkingMock = nil
        viewModel = nil
    }
    
    func testSuccessPlacesResponse() async throws {
        try await viewModel.loadPlaces()
        XCTAssertEqual(viewModel.places.count, 2, "There shoud contain 2 places")
        XCTAssertNil(viewModel.places[0].imageURL, "ImageURL should equal nil")
        XCTAssertNil(viewModel.places[1].imageURL, "ImageURL should equal nil")
    }
    
    func testSuccessImageURLsResponse() async throws {
        try await viewModel.loadPlaces()
        try await viewModel.loadPlacesImageURLs()
        XCTAssertEqual(viewModel.places.count, 2, "There shoud contain 2 places")
        XCTAssertNotNil(viewModel.places[0].imageURL, "ImageURL shouldn't be nil")
        XCTAssertNotNil(viewModel.places[1].imageURL, "ImageURL shouldn't be nil")
    }
}
