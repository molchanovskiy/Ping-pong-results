//
//  Constants.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

struct Constants {

	static let MY_INSTANCE_ADDRESS = "ping-pong-results.us1.cloud.realm.io"
	
	static let AUTH_URL  = URL(string: "https://\(MY_INSTANCE_ADDRESS)")!
	static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/~/UsersData")!
}
