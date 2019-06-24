//
//  AppManager.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class AppManager {
	
	// MARK: - Variables
	
	static let shared = AppManager()
	
	// MARK: - Initialization
	
	init() {
		populateTestData()
	}
	
	// MARK: - Functions
	
	/**
	Returns Game objects array sorted by date.
	*/
	func getGameObjects() -> [Game] {
		if let games = RealmManager.shared.getObjectsWith(type: Game.self)?.toArray(ofType: Game.self), games.count > 0 {
			return games.sorted(by: { (game1, game2) -> Bool in
				return game1.date > game2.date
			})
		} else {
			return []
		}
	}
	
	/**
	Returns favourite Game objects array sorted by date.
	*/
	func getFavouriteGameObjects() -> [Game] {
		let games = getGameObjects().filter { (game) -> Bool in
			return game.favourite
		}
		if games.count > 0 {
			return games
		} else {
			return []
		}
	}
	
	/**
	Returns Player objects array sorted by PlayerSorting value.
	
	- parameter sorted: optional value to sort players by points, wins or losses, default is points
	*/
	func getPlayers(sorted:PlayerSorting = .points) -> [Player] {
		if let players = RealmManager.shared.getObjectsWith(type: Player.self)?.toArray(ofType: Player.self), players.count > 0 {
			switch sorted {
			case .wins:
				return players.sorted(by: { (player1, player2) -> Bool in
					return player1.totalWins > player2.totalWins
				})
			case .losses:
				return players.sorted(by: { (player1, player2) -> Bool in
					return player1.totalLosses > player2.totalLosses
				})
			case .points:
				return players.sorted(by: { (player1, player2) -> Bool in
					return player1.points > player2.points
				})
			}
		} else {
			return []
		}
	}
	
	// MARK: - Private Functions
	
	/**
	Populates test Games objects and stores them to Realm database
	*/
	private func populateTestData() {
		if let games = RealmManager.shared.getObjectsWith(type: Game.self), games.count == 0 {
			var newGames:[Game] = []
			RealmManager.shared.write {
				let defaultFirstPlayers:[String] = ["Darcis S.", "Oliveira G.", "Troicki V.", "Aragone J.", "Kecmanovic M.", "Londero J. I.", "Rublev A.", "Bublik A.", "Kudla D.", "Federer R.", "Darcis S.", "Gomez-Herrera C.", "Ortega-Olmedo R.", "Krawietz K."]
				let defaultFirstPlayersScores:[Int] = [2, 1, 2, 2, 2, 0, 3, 1, 0, 2, 3, 1, 2, 3]
				let defaultSecondsPlayers:[String] = ["Gomez-Herrera C.", "Krawietz K.", "Ortega-Olmedo R.", "Huesler M.", "Munar J.", "Fabbiano T.", "Jubb P.", "Sandgren T.", "Ward J.", "Goffin D.", "Goffin D.", "Troicki V.", "Kecmanovic M.", "Darcis S."]
				let defaultSecondsPlayersScores:[Int] = [0, 2, 1, 0, 0, 2, 2, 2, 2, 0, 2, 0, 1, 0]
				
				for firstPlayerName in defaultFirstPlayers {
					let firstPlayerScore = defaultFirstPlayersScores[defaultFirstPlayers.firstIndex(of: firstPlayerName)!]
					let secondsPlayerName = defaultSecondsPlayers[defaultFirstPlayers.firstIndex(of: firstPlayerName)!]
					let secondPlayerScore = defaultSecondsPlayersScores[defaultFirstPlayers.firstIndex(of: firstPlayerName)!]
					
					let firstPlayer:Player = RealmManager.shared.realm.objects(Player.self).filter({$0.name == firstPlayerName}).first ?? Player.init(name: firstPlayerName)
					let secondPlayer:Player = RealmManager.shared.realm.objects(Player.self).filter({$0.name == secondsPlayerName}).first ?? Player.init(name: secondsPlayerName)
					RealmManager.shared.realm.add(firstPlayer)
					RealmManager.shared.realm.add(secondPlayer)
					
					let game = Game.init(firstPlayer: firstPlayer, firstPlayerScore: firstPlayerScore, secondPlayer: secondPlayer, secondPlayerScore: secondPlayerScore, date: Date())
					newGames.append(game)
				}
			}
			RealmManager.shared.save(objects: newGames, update: .error)
		}
	}
	
}
