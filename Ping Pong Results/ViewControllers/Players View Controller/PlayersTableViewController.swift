//
//  PlayersTableViewController.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {
	
	// MARK: - Variables
	
	var players:[Player] = AppManager.shared.getPlayers() {
		didSet {
			tableView.reloadData()
		}
	}
	var playersSortType:PlayerSorting = .points
	
	// MARK: - View Controller life-cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//set view controllers navigation bar title
		title = "Players"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		players = AppManager.shared.getPlayers(sorted: playersSortType)
	}
	
	//MARK: - Actions
	
	@objc func sortButtonDidTap(_ sender: Any) {
		let alert = UIAlertController.init(title: "Sort by:", message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction.init(title: "Points", style: .default, handler: { (action) in
			self.playersSortType = .points
			self.players = AppManager.shared.getPlayers(sorted: .points)
		}))
		alert.addAction(UIAlertAction.init(title: "Wins", style: .default, handler: { (action) in
			self.playersSortType = .wins
			self.players = AppManager.shared.getPlayers(sorted: .wins)
		}))
		alert.addAction(UIAlertAction.init(title: "Losses", style: .default, handler: { (action) in
			self.playersSortType = .losses
			self.players = AppManager.shared.getPlayers(sorted: .losses)
		}))
		alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
			
		}))
		present(alert, animated: true)
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return players.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:PlayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.className, for: indexPath) as! PlayerTableViewCell
		let player = players[indexPath.row]
		// Configure the cell...
		cell.populate(player: player)
		
		return cell
	}
	
	// MARK: - Table view delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
