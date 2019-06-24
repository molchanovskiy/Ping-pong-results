//
//  Game.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import RealmSwift


class Game: Object {
	
	// MARK: - Variables
	
	@objc dynamic var firstPlayer:Player!
	@objc dynamic var firstPlayerScore:Int = 0
	@objc dynamic var secondPlayer:Player!
	@objc dynamic var secondPlayerScore:Int = 0
	@objc dynamic var date:Date = Date()
	@objc dynamic var favourite:Bool = false
	
	// MARK: - Initialization
	
	/**
	Iinitializes an Game object.
	
	- parameter firstPlayer: first Player object to be added to this Realm.
	- parameter firstPlayerScore: first player score for current match
	- parameter secondPlayer: second Player object to be added to this Realm.
	- parameter secondPlayerScore: second player score for current match
	- parameter date: date of current match
	*/
	convenience init(firstPlayer:Player, firstPlayerScore:Int = 0, secondPlayer:Player, secondPlayerScore:Int = 0, date:Date = Date()) {
		self.init()
		self.firstPlayer = firstPlayer
		self.firstPlayerScore = firstPlayerScore
		self.secondPlayer = secondPlayer
		self.secondPlayerScore = secondPlayerScore
		self.date = date
		
		//check if first player won, increment total wins and increment second player total losses
		if firstPlayerScore > secondPlayerScore {
			firstPlayer.incrementTotalScore(scoreType: .win)
			secondPlayer.incrementTotalScore(scoreType: .losse)
		//check if second player won, increment total wins and increment first player total losses
		} else if secondPlayerScore > firstPlayerScore {
			secondPlayer.incrementTotalScore(scoreType: .win)
			firstPlayer.incrementTotalScore(scoreType: .losse)
		}
		firstPlayer.incrementPoints(points: firstPlayerScore)
		secondPlayer.incrementPoints(points: secondPlayerScore)
	}
}

enum PlayerScore {
	case win
	case losse
}

enum PlayerSorting {
	case wins
	case losses
	case points
}

class Player: Object {
	
	// MARK: - Variables
	
	@objc dynamic var name = ""
	@objc dynamic var points = 0
	@objc dynamic var totalWins = 0
	@objc dynamic var totalLosses = 0
	
	// MARK: - Initialization
	
	/**
	Iinitializes an Player object.
	
	- parameter name: player name.
	*/
	convenience init(name:String) {
		self.init()
		self.name = name
	}
	
	// MARK: - Functions
	
	/**
	Increments total player score.
	
	- parameter scoreType: score type .win in case of win score, .lose in case of lose score
	- parameter score: score to add totalWins or totalLosses variables
	*/
	func incrementTotalScore(scoreType:PlayerScore) {
		switch scoreType {
		case .win:
			totalWins = totalWins + 1
		case .losse:
			totalLosses = totalLosses + 1
		}
	}
	
	/**
	Increments total player points.
	
	- parameter points: points to add points variable
	*/
	func incrementPoints(points:Int) {
		self.points = self.points + points
	}
}
