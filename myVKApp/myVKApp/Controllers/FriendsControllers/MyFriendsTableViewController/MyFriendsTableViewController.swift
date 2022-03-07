//
//  MyFriendsTableViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 06.12.2021.
//

import UIKit
import Kingfisher

class MyFriendsTableViewController: UITableViewController {

	private var data = [Friend]()

	var friends: [FriendsSection] = []
	var lettersOfNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor(red: 0.738, green: 0.628, blue: 0.884, alpha: 0.5)
        self.tableView.showsVerticalScrollIndicator = false
        VkService.shared.getFriends(Session.shared.userID) { [weak self] friendsList in
			DispatchQueue.main.async {
				guard let self = self else { return }
				self.data = friendsList
				self.friends = FriendsLoader.getFriendSections(data: self.data)
				self.loadLetters()
				self.tableView.reloadData()
			}
		}
		self.tableView.sectionHeaderTopPadding = 0
    }
    
    func loadLetters() {
		for friend in friends {
			 lettersOfNames.append(String(friend.key))
		}
	}

    // MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return friends.count
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends[section].data.count
    }
    
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let section = friends[section]
		return String(section.key)
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCellID", for: indexPath) as? FriendCell
		else {
			return UITableViewCell()
		}
		
		let section = friends[indexPath.section]
		let name = section.data[indexPath.row].lastName + " " + section.data[indexPath.row].firstName

        friendCell.friendName.text = name
        friendCell.friendAvatar.imageView?.kf.setImage(with: URL(string: section.data[indexPath.row].avatar))
 
        return friendCell
    }
    
	override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return lettersOfNames
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = UIView()
		header.backgroundColor = tableView.backgroundColor
		header.alpha = 1
		
		let letter = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
		letter.textColor = .black
		letter.text = lettersOfNames[section]
		letter.font = UIFont.systemFont(ofSize: 14)
		header.addSubview(letter)
		
		return header
	}
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "FriendDataSegue" {
			if let desctinationViewController = segue.destination as? MyFriendViewController,
			   let cell = sender as? FriendCell {
				if let indexPath = tableView.indexPath(for: cell) {
					print(">>> indexPath: \(indexPath)")
					desctinationViewController.image = UIImage(named: "friend1")
				}
			}
		}
	}
	
}
