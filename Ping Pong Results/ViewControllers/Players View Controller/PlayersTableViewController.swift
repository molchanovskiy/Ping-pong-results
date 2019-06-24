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
	
	@IBAction func sortButtonDidTap(_ sender: Any) {
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
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
