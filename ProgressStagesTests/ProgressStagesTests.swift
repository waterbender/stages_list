//
//  ProgressStagesTests.swift
//  ProgressStagesTests
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import XCTest
@testable import ProgressStages

class ProgressStagesTests: XCTestCase {

    let service = StagesService()

    func testParseCodable() {

        let expectation = XCTestExpectation(description: "Download")

        service.getStagesForStep(step: 1,
                                 compliteClousure: { steps in
                                    XCTAssertEqual(!steps.isEmpty, true)
                                    expectation.fulfill()
        }, failure: { _ in
        })
        wait(for: [expectation], timeout: 5)
    }

}
