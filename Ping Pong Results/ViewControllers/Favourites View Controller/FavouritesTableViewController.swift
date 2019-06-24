//
//  FavouritesTableViewController.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class FavouritesTableViewController: NoDataTableViewController {
	
	// MARK: - Variables
	
	var games:[Game] = AppManager.shared.getFavouriteGameObjects() {
		didSet {
			tableView.reloadData()
		}
	}
	
	// MARK: - View Controller life-cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//set view controllers navigation bar title
		title = "Favourites"
		
		let rightButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing(sender:)))
		navigationItem.rightBarButtonItem = rightButton
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		games = AppManager.shared.getFavouriteGameObjects()
		
		checkIfDataExistAndShowEmptyViewIfNeeded()
		checkEditingState()
	}
	
	// MARK: - Actions
	
	func checkIfDataExistAndShowEmptyViewIfNeeded() {
		if games.count == 0 {
			noDataLabelView.isHidden = false
		} else {
			noDataLabelView.isHidden = true
		}
		noDataLabel?.text = "No favorites added yet!"
	}
	
	func checkEditingState() {
		if tableView.isEditing == true {
			navigationItem.rightBarButtonItem?.title = "Done"
		} else {
			navigationItem.rightBarButtonItem?.title = "Edit"
		}
	}
	
	@objc func showEditing(sender: UIBarButtonItem) {
		if tableView.isEditing == true {
			tableView.isEditing = false
		} else {
			tableView.isEditing = true
		}
		checkEditingState()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return games.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:FavouriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.className, for: indexPath) as! FavouriteTableViewCell
		let game = games[indexPath.row]
		// Configure the cell...
		cell.populate(game: game)
		
		return cell
	}
	
	// MARK: - Table view delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			let game = games[indexPath.row]
			RealmManager.shared.write {
				game.favourite = false
			}
			games.remove(at: games.firstIndex(of: game)!)
			
			if games.count == 0 {
				checkIfDataExistAndShowEmptyViewIfNeeded()
				tableView.isEditing = false
				checkEditingState()
			}
		}
	}
	
}
