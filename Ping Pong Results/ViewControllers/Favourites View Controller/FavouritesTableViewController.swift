//
//  FavouritesTableViewController.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
	
	// MARK: - Variables
	
	var games:[Game] = AppManager.shared.getFavouriteGameObjects() {
		didSet {
			tableView.reloadData()
		}
	}
	
	lazy var noDataLabelView: UIView = {
		let label = UILabel()
		
		// Enable Dynamic Type:
		label.font = UIFont.preferredFont(forTextStyle: .callout)
		label.adjustsFontForContentSizeCategory = true
		
		// Style label with white text:
		label.textColor = .white
		label.backgroundColor = .clear
		label.text = "No favorites added yet!"
		
		// Style a grey background with rounded corners:
		let noDataView = UIView()
		noDataView.isHidden = true
		noDataView.backgroundColor = UIColor.darkGray
		noDataView.layer.cornerRadius = 4
		noDataView.layer.masksToBounds = true
		
		// Set constraints of view around label:
		noDataView.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		noDataView.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: noDataView, attribute: .leading, multiplier: 1.0, constant: 12))
		noDataView.addConstraint(NSLayoutConstraint(item: noDataView, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1.0, constant: 12))
		noDataView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: noDataView, attribute: .top, multiplier: 1.0, constant: 6))
		noDataView.addConstraint(NSLayoutConstraint(item: noDataView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1.0, constant: 6))
		
		// Set constraints to position view at top of tableview:
		self.tableView.addSubview(noDataView)
		noDataView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.addConstraint(NSLayoutConstraint(item: noDataView, attribute: .centerX, relatedBy: .equal, toItem: self.tableView, attribute: .centerX, multiplier: 1.0, constant: 0))
		self.tableView.addConstraint(NSLayoutConstraint(item: noDataView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self.tableView, attribute: .width, multiplier: 0.92, constant: 0))
		self.tableView.addConstraint(NSLayoutConstraint(item: noDataView, attribute: .top, relatedBy: .equal, toItem: self.tableView, attribute: .top, multiplier: 1.0, constant: 40))
		
		return noDataView
	}()
	
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
