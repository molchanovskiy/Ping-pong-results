//
//  RealmManager.swift
//  Ping Pong Results
//
//  Created by Andrey Molchanovskiy on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {

	// MARK: - Variables
	
	static let shared = RealmManager()
	var realm: Realm = try! Realm()
	
	// MARK: - Functions
	
	/**
	Adds an unmanaged object to this Realm.
	
	- parameter object: The object to be added to this Realm.
	- parameter update: What to do if an object with the same primary key alredy exists. Must be `.error` for objects
	without a primary key. Default is .error .
	*/
	func save(object: Object, update: Realm.UpdatePolicy = .error) {
		
		try! realm.write({
			if !object.isInvalidated {
				realm.add(object, update: update)
			}
		})
	}
	
	/**
	Adds an unmanaged objects to this Realm.
	
	- parameter objects: The objects to be added to this Realm.
	- parameter update: What to do if an objects with the same primary key alredy exists. Must be `.error` for objects
	without a primary key. Default is .error .
	*/
	func save(objects: [Object], update: Realm.UpdatePolicy = .error) {
		
		try! realm.write({
			realm.add(objects, update: update)
		})
	}
	
	/**
	Returns all objects of the given type stored in the Realm.
	
	- parameter type: The type of the objects to be returned.
	- returns: A `Results` containing the objects.
	*/
	func getObjectsWith(type: Object.Type) -> Results<Object>? {
		return realm.objects(type)
	}
	
	/**
	Deletes an object from the Realm. Once the object is deleted it is considered invalidated.
	
	- parameter object: The object to be deleted.
	*/
	func remove(object: Object) {
		try! realm.write({
			if !object.isInvalidated {
				realm.delete(object)
			}
		})
	}
	
	/**
	Deletes all objects of the given type stored to Realm. Once the objects is deleted it is considered invalidated.
	
	- parameter type: The object type to be deleted.
	*/
	func removeAll(for type: Object.Type) {
		if let result = getObjectsWith(type: type) {
			try! realm.write {
				realm.delete(result)
			}
		}
	}
	
	/**
	Performs actions contained within the given block inside a write transaction.
	
	- parameter block: The block containing actions to perform.
	*/
	func write(callback: ()->Void) {
		try? realm.write {
			callback()
		}
	}
}
