//
//  GamesTableViewController.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import RealmSwift

class GamesTableViewController: NoDataTableViewController {
	
	// MARK: - Variables
	
	var games:[Game] = AppManager.shared.getGameObjects() {
		didSet {
			tableView.reloadData()
			checkIfUserLoggedInAndUpdateNavigationBarButtons()
			checkIfDataExistAndShowEmptyViewIfNeeded()
		}
	}
	
	// MARK: - View Controller life-cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//set view controllers navigation bar title
		title = "Games"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		checkIfUserLoggedInAndUpdateNavigationBarButtons()
		games = AppManager.shared.getGameObjects()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	// MARK: - Functions
	
	func checkIfUserLoggedInAndUpdateNavigationBarButtons() {
		
		if AuthenticationManager.shared.isLoggedIn() {
			let signOutButton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "sign_out_icon"), style: .plain, target: self, action: #selector(signOut))
			navigationItem.leftBarButtonItems = nil
			navigationItem.leftBarButtonItem = signOutButton
		} else {
			let signInButton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "sign_in_icon"), style: .plain, target: self, action: #selector(signIn))
			let signUpButton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "sign_up_icon"), style: .plain, target: self, action: #selector(signUp))
			navigationItem.leftBarButtonItems = [signInButton, signUpButton]
		}
	}
	
	// MARK: - Actions
	
	func checkIfDataExistAndShowEmptyViewIfNeeded() {
		if games.count == 0 {
			noDataLabelView.isHidden = false
		} else {
			noDataLabelView.isHidden = true
		}
		noDataLabel?.text = "No games added yet!"
	}
	
	@objc func signIn() {
		AuthenticationManager.shared.presentLoginInView(presentingViewController: self) { (user, error) in
			if user != nil {
				RealmManager.shared.checkIfUserLoggedInAndUpdateRealmInstanseIfNeeded()
				self.games = AppManager.shared.getGameObjects()
			} else if let error = error {
				self.presentError(text: error.localizedDescription)
			}
		}
	}
	
	@objc func signUp() {
		AuthenticationManager.shared.presentLoginInView(presentingViewController: self, createAccount: true) { (user, error) in
			if user != nil {
				RealmManager.shared.checkIfUserLoggedInAndUpdateRealmInstanseIfNeeded()
				self.games = AppManager.shared.getGameObjects()
			} else if let error = error {
				self.presentError(text: error.localizedDescription)
			}
		}
	}
	
	@objc func signOut() {
		AuthenticationManager.shared.signOut(presentingViewController: self) { (result) in
			if result {
				self.games = AppManager.shared.getGameObjects()
			}
		}
	}
	
	func presentError(text:String) {
		let alertViewController = UIAlertController.init(title: "Oooopds!", message: text, preferredStyle: .alert)
		alertViewController.addAction(UIAlertAction.init(title: "OK", style: .cancel))
		present(alertViewController, animated: true)
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
		let cell:GameTableViewCell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.className, for: indexPath) as! GameTableViewCell
		let game = games[indexPath.row]
		// Configure the cell...
		cell.populate(game: game)
		
		return cell
	}
	
	// MARK: - Table view delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
