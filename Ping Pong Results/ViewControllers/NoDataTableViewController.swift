//
//  NoDataTableViewController.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class NoDataTableViewController: UITableViewController {

	var noDataLabel:UILabel?
	lazy var noDataLabelView: UIView = {
		let label = UILabel()
		noDataLabel = label
		// Enable Dynamic Type:
		label.font = UIFont.preferredFont(forTextStyle: .callout)
		label.adjustsFontForContentSizeCategory = true
		
		// Style label with white text:
		label.textColor = .white
		label.backgroundColor = .clear
		label.text = "No data!"
		
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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

	/*
   override func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 0
   }
    */
   /*
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of rows
       return 0
   }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
