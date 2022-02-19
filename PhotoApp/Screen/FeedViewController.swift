//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 18.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postModel = [PostModdel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    
    func getData(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                if ( snapshot?.isEmpty != true && snapshot != nil ){
                    
                    self.postModel.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents {
                        //let documentId = document.documentID
                        if let imageUrl =  document.get("imageUrl") as? String{
                            if let command = document.get("command") as? String {
                                if let userMail = document.get("email") as? String {
                                    let post = PostModdel(email: userMail, command: command, imageUrl: imageUrl)
                                    self.postModel.append(post)
                                }
                            }
                        }
                        
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.emailTextLabel.text = postModel[indexPath.row].email
        cell.postImageView.sd_setImage(with: URL(string: self.postModel[indexPath.row].imageUrl))
        cell.commandTextLabel.text = postModel[indexPath.row].command
        return cell
    }
    
}
