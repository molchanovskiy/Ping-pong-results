//
//  AddGameViewController.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SearchTextField

class AddGameViewController: UIViewController {
	
	// MARK: - Variables
	
	@IBOutlet weak var txtPlayer1Name: SearchTextField!
	@IBOutlet weak var txtPlayer1Score: UITextField!
	
	@IBOutlet weak var txtPlayer2Name: SearchTextField!
	@IBOutlet weak var txtPlayer2Score: UITextField!
	
	// MARK: - View Controller life-cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		//setup players autocomplete text fields
		if let players = RealmManager.shared.getObjectsWith(type: Player.self)?.toArray(ofType: Player.self), players.count > 0 {
			var playerNames:[String] = []
			for player in players {
				playerNames.append(player.name)
			}
			txtPlayer1Name.filterStrings(playerNames)
			txtPlayer1Name.startVisible = true
			txtPlayer2Name.filterStrings(playerNames)
			txtPlayer2Name.startVisible = true
		}
		//setup save navigation bar button
		let saveButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveGameDidTap(_:)))
		navigationItem.rightBarButtonItem = saveButton

		//setup tap gesture recognizer to hide keyboard
		view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard)))
	}
	
	// MARK: - Actions
	
	@objc func hideKeyboard() {
		view.endEditing(true)
	}
	
	@IBAction func saveGameDidTap(_ sender: Any) {
		//Check if first player and second player names are not empty and save game to database
		if let firstPlayerName = txtPlayer1Name.text, let secondsPlayerName = txtPlayer2Name.text, !firstPlayerName.isEmpty, !secondsPlayerName.isEmpty {
			RealmManager.shared.write {
				let firstPlayer:Player = RealmManager.shared.realm.objects(Player.self).filter({$0.name == firstPlayerName}).first ?? Player.init(name: firstPlayerName)
				let secondPlayer:Player = RealmManager.shared.realm.objects(Player.self).filter({$0.name == secondsPlayerName}).first ?? Player.init(name: secondsPlayerName)
				RealmManager.shared.realm.add(firstPlayer)
				RealmManager.shared.realm.add(secondPlayer)
				
				if let firstPlayerScore = Int("\(txtPlayer1Score.text ?? "0")"), let secondPlayerScore = Int("\(txtPlayer2Score.text ?? "0")") {
					let game = Game.init(firstPlayer: firstPlayer, firstPlayerScore: firstPlayerScore, secondPlayer: secondPlayer, secondPlayerScore: secondPlayerScore, date: Date())
					RealmManager.shared.realm.add(game)
				}
				navigationController?.popViewController(animated: true)
			}
		} else {
			let alertViewController = UIAlertController.init(title: "Ooooos!", message: "Player1 or Player2 name is empty!", preferredStyle: .alert)
			alertViewController.addAction(UIAlertAction.init(title: "OK", style: .cancel))
			present(alertViewController, animated: true)
		}
	}
}

//MARK: - UITextFieldDelegate

extension AddGameViewController : UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		//Return button actions
		if textField == txtPlayer1Name {
			txtPlayer1Score.becomeFirstResponder()
		} else if textField == txtPlayer1Score {
			txtPlayer2Name.becomeFirstResponder()
		} else if textField == txtPlayer2Name {
			txtPlayer2Score.becomeFirstResponder()
		} else if textField == txtPlayer2Score {
			saveGameDidTap(self)
		}
		return true
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		//allow only number caracters for score fields
		if textField == txtPlayer1Score || textField == txtPlayer2Score {
			let allowedCharacters = CharacterSet(charactersIn:"0123456789")
			let characterSet = CharacterSet(charactersIn: string)
			return allowedCharacters.isSuperset(of: characterSet)
		}
		return true
	}
	
}
