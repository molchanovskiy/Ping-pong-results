//
//  NSObjectAdditions.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
	var className: String {
		return String(describing: type(of: self)).components(separatedBy: ".").last!
	}
	
	class var className: String {
		return String(describing: self).components(separatedBy: ".").last!
	}
	
	class var storyboard: UIStoryboard {
		return UIStoryboard.init(name: self.className, bundle: nil)
	}
}
