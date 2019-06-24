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
		game.secondPlayer.incrementTotalScore(scoreType: .losse)
		XCTAssert(game.firstPlayer.totalWins == 2, "First player totalWins not equal to 2")
		XCTAssert(game.secondPlayer.totalLosses == 2, "Second player player totalLosses score not equal to 2")
	}
	
	func testCreatePlayer() {
		let playerName = "Ping pong champion"
		let wins = 10
		let losses = 2
		let player = Player.init(name: playerName)
		player.totalWins = wins
		player.totalLosses = losses
		
		XCTAssertNotNil(player, "Player object nil")
		
		//Check if scores are stored correct
		XCTAssert(player.totalWins == wins, "player wins not equal to \(wins)")
		XCTAssert(player.totalLosses == losses, "player losses not equal to \(losses)")
		
		//Check if incrementing total scores works correct
		player.incrementTotalScore(scoreType: .win)
		XCTAssert(player.totalWins == wins+1, "player wins not equal to \(wins+1)")
		player.incrementTotalScore(scoreType: .losse)
		XCTAssert(player.totalLosses == losses+1, "player losses not equal to \(losses+1)")
	}
	
	func testDatabase() {
		//create game
		let game = Game.init(firstPlayer: Player.init(name: "First Player"), firstPlayerScore: 6, secondPlayer: Player.init(name: "Second Player"), secondPlayerScore: 5, date: Date())
		XCTAssertNotNil(game, "Game object nil")
		RealmManager.shared.save(object: game)
		
		//retrieve game from database
		var gamesFromDataBase = RealmManager.shared.getObjectsWith(type: Game.self)?.toArray(ofType: Game.self)
		XCTAssertNotNil(gamesFromDataBase, "games from data base nil")
		
		//retrieve player from database
		var playersFromDataBase = RealmManager.shared.getObjectsWith(type: Player.self)?.toArray(ofType: Player.self)
		XCTAssertNotNil(playersFromDataBase, "players from data base nil")
		
		//delete games from database
		RealmManager.shared.removeAll(for: Game.self)
		//retrieve game from database
		gamesFromDataBase = RealmManager.shared.getObjectsWith(type: Game.self)?.toArray(ofType: Game.self)
		XCTAssert(gamesFromDataBase?.count == 0, "Game objects still exist in database after deleting")
		
		
		//delete players from database
		RealmManager.shared.removeAll(for: Player.self)
		//retrieve players from database
		playersFromDataBase = RealmManager.shared.getObjectsWith(type: Player.self)?.toArray(ofType: Player.self)
		XCTAssert(playersFromDataBase?.count == 0, "Player objects still exist in database after deleting")
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
