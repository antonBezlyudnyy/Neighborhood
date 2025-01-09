//
//  PlacesViewModelFailureTests.swift
//  NeighborhoodTests
//
//  Created by Anton Bezlyudnyy on 10/10/24.
//

import XCTest
@testable import Neighborhood

final class PlacesListViewModelFailureTests: XCTestCase {
    private var netWorkingMock: NetworkManagerImpl!
    private var viewModel: PlaceListViewModel!
    
    override func setUp() {
        netWorkingMock = PlacesResponseFailureMock()
        viewModel = PlaceListViewModel(networkManager: netWorkingMock)
    }
    
    override func tearDown() {
        netWorkingMock = nil
        viewModel = nil
    }
    
    func testFailurePlacesResponse() async throws {
        try await viewModel.loadPlaces()
        XCTAssertEqual(viewModel.places.count, 0)
        try await viewModel.loadPlacesImageURLs()
        XCTAssertTrue(viewModel.places.isEmpty)
    }
}
