//
//  GameTableViewCell.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
	
	// MARK: - Variables
	
	@IBOutlet weak var firstPlayerLabel: UILabel!
	@IBOutlet weak var firstPlayerScore: UILabel!
	@IBOutlet weak var secondPlayerLabel: UILabel!
	@IBOutlet weak var secondPlayerScore: UILabel!
	@IBOutlet weak var btnFavourite: UIButton!
	var game:Game?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	
	func populate(game:Game) {
		self.game = game
		
		firstPlayerLabel.text = game.firstPlayer.name
		firstPlayerScore.text = "\(game.firstPlayerScore)"
		
		secondPlayerLabel.text = game.secondPlayer.name
		secondPlayerScore.text = "\(game.secondPlayerScore)"
		
		if game.firstPlayerScore > game.secondPlayerScore {
			firstPlayerLabel.font = UIFont.boldSystemFont(ofSize: 17)
			firstPlayerScore.font = UIFont.boldSystemFont(ofSize: 17)
			secondPlayerLabel.font = UIFont.systemFont(ofSize: 17)
			secondPlayerScore.font = UIFont.systemFont(ofSize: 17)
		} else if game.secondPlayerScore > game.firstPlayerScore {
			firstPlayerLabel.font = UIFont.systemFont(ofSize: 17)
			firstPlayerScore.font = UIFont.systemFont(ofSize: 17)
			secondPlayerLabel.font = UIFont.boldSystemFont(ofSize: 17)
			secondPlayerScore.font = UIFont.boldSystemFont(ofSize: 17)
		} else {
			firstPlayerLabel.font = UIFont.systemFont(ofSize: 17)
			firstPlayerScore.font = UIFont.systemFont(ofSize: 17)
			secondPlayerLabel.font = UIFont.systemFont(ofSize: 17)
			secondPlayerScore.font = UIFont.systemFont(ofSize: 17)
		}
		updateFavouriteButtonIcon(game: game)
	}
	
	func updateFavouriteButtonIcon(game:Game) {
		if game.favourite {
			btnFavourite.setImage(#imageLiteral(resourceName: "star_selected"), for: .normal)
		} else {
			btnFavourite.setImage(#imageLiteral(resourceName: "star_deselected"), for: .normal)
		}
	}
	
	@IBAction func favouriteButtonDidTap(_ sender: Any) {
		if let game = game {
			RealmManager.shared.write {
				game.favourite = !game.favourite
				self.updateFavouriteButtonIcon(game: game)
			}
		}
	}
}
