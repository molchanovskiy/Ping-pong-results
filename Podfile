# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

def shared_pods
	# RealmSwift
	# ==========
	# Source:     https://github.com/realm/realm-cocoa
	# Purpose:    Used to store objects in local db, all our djambo items, and local djambo items, stored with realm.
	pod 'RealmSwift', '3.16.2'
end

target 'Ping Pong Results' do
	# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
	use_frameworks!
	platform :ios, '11.0'
	
	# ignore all warnings from all pods
	inhibit_all_warnings!
	shared_pods
	
	# SearchTextField
	# ==========
	# Source:     https://github.com/apasccon/SearchTextField
	# Purpose:    Used to show autocomplete results for players while adding new game
	pod 'SearchTextField'
	
end

target 'Ping Pong ResultsTests' do
	use_frameworks!
	shared_pods
end
