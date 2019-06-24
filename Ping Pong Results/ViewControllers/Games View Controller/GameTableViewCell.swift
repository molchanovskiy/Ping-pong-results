//
//  GameTableViewCell.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class GameTableViewCell: FavouriteTableViewCell {
	
	// MARK: - Variables

	@IBOutlet weak var btnFavourite: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	override func populate(game:Game) {
		super.populate(game:game)
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
