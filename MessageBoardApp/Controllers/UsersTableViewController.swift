//
//  UsersTableViewController.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    let jDownloader = UserJsonDownloader()
    var users: [User] = []
 
    let cellIdentifier = "test"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
        fetchUsers()
    }
    
    func viewSetUp() {
        self.title = "Users"
        self.tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        self.tableView.rowHeight = 60.0
        
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    func fetchUsers(){
        jDownloader.getModelGen(for: .Users) { (users:[User]?,error:Error?) in
                   guard let users = users else {
                       print("no data got")
                       return
                   }
                   self.users = users
                   //print(users)
                   DispatchQueue.main.async {
                       self.reloadData()
                   }
               }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsersTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UsersTableViewCell

        cell.configure(withUser: users[indexPath.row])
        
        PhotoDownloader.loadImage(from: users[indexPath.row].iconAddress ){image,_ in
            guard let img = image else {
                return 
            }
        DispatchQueue.main.async {
            cell.profileImage.image = img
        
        }
      
        }
          return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.tableView.deselectRow(at: indexPath, animated: true)
               
               let detailViewController = ProfileTableViewController.instantiate(withUser: users[indexPath.row])
               
               self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
