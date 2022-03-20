//
//  MyGroupsTableViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 05.12.2021.
//

import UIKit
import Kingfisher
import RealmSwift

class MyGroupsTableViewController: UITableViewController {

	private var groups = [Group]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		VkService.shared.getUserGroupsList(Session.shared.userID) { [weak self] groupsList in
			DispatchQueue.main.async {
				self?.saveGroups(groupsList)
				self?.groups = self!.getGroupsFromRealm()
				self?.tableView.reloadData()
			}
		}
		
		tableView.reloadData()
	}
	
	func saveGroups(_ data: [Group]) {
		do {
			// create realm (do-catch is mandatory)
			let realm = try Realm()
			//write to DB:
			realm.beginWrite()
			realm.add(data)
			try realm.commitWrite()
		} catch {
			print(error)
		}
	}
	
	func getGroupsFromRealm() -> [Group] {
		var groups = [Group]()
		do {
			let realm = try Realm()
			let groupsData = realm.objects(Group.self)
			groups = Array(groupsData)
		} catch {
			print(error)
		}
		return groups
	}
	
	// MARK: - Table view data source
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCellID", for: indexPath) as? GroupCell
		else {
			return UITableViewCell()
		}
		
		let url = URL(string: groups[indexPath.row].avatar)
		groupCell.groupAvatar.kf.setImage(with: url)
		groupCell.groupName.text = groups[indexPath.row].groupName
		
		return groupCell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			groups.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			tableView.reloadData()
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
//	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//		if editingStyle == .delete {
//			Groups.shared.leave(indexPath.row)
//			tableView.deleteRows(at: [indexPath], with: .fade)
//			tableView.reloadData()
//		} else if editingStyle == .insert {
//			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//		}
//	}
	
	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
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
