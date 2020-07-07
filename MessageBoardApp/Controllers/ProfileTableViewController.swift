//
//  ProfileTableViewController.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    static func instantiate(withUser user: User) -> ProfileTableViewController {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let detailViewController = storyboard.instantiateViewController(withIdentifier: "ProfileTableViewController") as! ProfileTableViewController
         detailViewController.user = user
         
         return detailViewController
     }
    
    let cellIdentifier = "test"
    let cellIdentifier2 = "test2"
    let headerCellIdentier = "test3"
    var posts: [Post] = []
    var comments: [Comment] = []
    var user:User!
    var userDetails:[(String,String)] = []
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let jDownloader = UserJsonDownloader()
    @IBOutlet weak var profileImageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
        fetchProfilePicture()
        fetchPostsAndComments()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           // print(userDetails[0].0)
            return userDetails.count
            
        }else {
            if posts.count > 0 {
                return posts.count
            }
            return 1
                }
    }
    
    override func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                   headerCellIdentier) as! ProfileViewHeader
        if section == 0 {
            view.mainTitle.text = "Details"
            view.commentTitle.text = ""
        } else {
            view.mainTitle.text = "Posts"
            view.commentTitle.text = "Comments"
        }
      

       return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell: ProfileDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProfileDetailTableViewCell
            cell.configure(withTitle: userDetails[indexPath.row].0, andText: userDetails[indexPath.row].1)
            
            return cell
            
        } else {
             let cell2: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2) as! PostTableViewCell
            if self.posts.count > 0 {
               
                cell2.configure(withTitle: posts[indexPath.row].title, andText: "\(calculateCommentAmount(post: posts[indexPath.row]))")
                
            } else  {
                cell2.configure(withTitle: "", andText: "loading")
                cell2.contentView.addSubview(activityView)
                activityView.center = cell2.contentView.center
                activityView.startAnimating()
                
            }
            return cell2
        }
    
    }
    //set up and helper methods
    func viewSetUp() {
        self.userDetails = self.user.getFormattedDetails()
        self.tableView.register(UINib(nibName: "ProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier:cellIdentifier2)
        self.tableView.register(ProfileViewHeader.self,forHeaderFooterViewReuseIdentifier: headerCellIdentier)
        
        self.title = user.username
        self.profileImageView.contentMode = UIView.ContentMode.scaleToFill
        
    }
    func fetchProfilePicture(){
        PhotoDownloader.loadImage(from: user.iconAddress) {img,_ in
            guard let image = img else {
                return
            }
            DispatchQueue.main.async{
               self.profileImageView.image = image
            }
            
        }
    }
    func fetchPostsAndComments(){
           jDownloader.getModelGen(for: .Posts) { (users:[Post]?,error:Error?) in
                      guard let users = users else {
                          print("no data got")
                          return
                      }
            self.posts = self.filterPosts(posts: users)
                      DispatchQueue.main.async {
                          self.reloadData()
                      }
                  }
        
        jDownloader.getModelGen(for: .Comments) { (users:[Comment]?,error:Error?) in
                  guard let users = users else {
                      print("no data got")
                      return
                  }
            print("\(users.count)")
             self.comments = users
                 // print(users)
                  DispatchQueue.main.async {
                      self.reloadData()
                  }
              }
       }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func filterPosts(posts:[Post]) -> [Post]{
        var ret:[Post] = []
        for post in posts {
            if post.userId == user.id {
                ret.append(post)
            }
        }
        return ret
    }
    
    func calculateCommentAmount(post:Post)->Int{
        var retVal = 0
        for comment in comments {
            if post.id == comment.postId {
                retVal += 1
               
            }
        }
      
        return retVal
    }
    
}
