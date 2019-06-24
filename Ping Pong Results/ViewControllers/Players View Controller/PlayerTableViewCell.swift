//
//  PlayerTableViewCell.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

	// MARK: - Variables
	
	@IBOutlet weak var playerNameLabel: UILabel!
	@IBOutlet weak var playerPointsLabel: UILabel!
	@IBOutlet weak var playerLossesLabel: UILabel!
	@IBOutlet weak var playerWinsLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func populate(player:Player) {
		playerNameLabel.text = player.name
		playerPointsLabel.text = "\(player.points)"
		playerLossesLabel.text = "\(player.totalLosses)"
		playerWinsLabel.text = "\(player.totalWins)"
	}

}
