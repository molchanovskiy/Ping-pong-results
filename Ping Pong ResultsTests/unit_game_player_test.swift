//
//  unit_game_player_test.swift
//  Ping Pong ResultsTests
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import Ping_Pong_Results

class unit_game_player_test: XCTestCase {

	//MARK: - TESTS
	
	func testCreateGame() {
		let game = Game.init(firstPlayer: Player.init(name: "First Player"), firstPlayerScore: 6, secondPlayer: Player.init(name: "Second Player"), secondPlayerScore: 5, date: Date())
		XCTAssertNotNil(game, "Game object nil")
		XCTAssertNotNil(game.firstPlayer, "Game firstPlayer object nil")
		XCTAssertNotNil(game.secondPlayer, "Game secondPlayer object nil")
		
		//Check if scores are stored correct
		XCTAssert(game.firstPlayerScore == 6, "First player score not equal to 6")
		XCTAssert(game.secondPlayerScore == 5, "First player score not equal to 5")
		
		//Check if total scores is stored correct
		XCTAssert(game.firstPlayer.totalWins == 1, "First player totalWins not equal to 1")
		XCTAssert(game.secondPlayer.totalLosses == 1, "Second player player totalLosses score not equal to 1")
		
		//Check if incrementing total scores works correct
		game.firstPlayer.incrementTotalScore(scoreType: .win)
		game.secondPlayer.incrementTotalScore(scoreType: .lose)
		XCTAssert(game.firstPlayer.totalWins == 2, "First player totalWins not equal to 2")
		XCTAssert(game.secondPlayer.totalLosses == 2, "Second player player totalLosses score not equal to 2")
	}
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
