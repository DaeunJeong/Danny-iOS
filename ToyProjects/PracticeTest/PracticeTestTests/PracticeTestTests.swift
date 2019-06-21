//
//  PracticeTestTests.swift
//  PracticeTestTests
//
//  Created by daeun on 21/06/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import XCTest
@testable import PracticeTest

class PracticeTestTests: XCTestCase {
    
    let sut = ViewController()

    override func setUp() {
        _ = sut.view
    }

    override func tearDown() {
        sut.num = 0
    }

    func test_buttons_and_label_exist() {
        XCTAssertEqual(sut._numLabel.text!, "0")
        XCTAssertEqual(sut._plusButton.currentTitle!, "click!!")
        XCTAssertEqual(sut._resetButton.currentTitle!, "reset")
    }

    func test_increase_num_when_button_clicked() {
        sut._plusButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.num, 1)
        XCTAssertEqual(sut._numLabel.text!, "1")
    }
    
    func test_reset_num_when_button_reset() {
        sut.num += 1
        sut._resetButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.num, 0)
        XCTAssertEqual(sut._numLabel.text!, "0")
    }
}
