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
    
    var userEmail = [String]()
    var command = [String]()
    var images = [String]()
    
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
                    
                    self.images.removeAll(keepingCapacity: false)
                    self.userEmail.removeAll(keepingCapacity: false)
                    self.command.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        //let documentId = document.documentID
                        if let imageUrl =  document.get("imageUrl") as? String{
                            self.images.append(imageUrl)
                        }
                        if let command = document.get("command") as? String {
                            self.command.append(command)
                        }
                        if let userMail = document.get("email") as? String {
                            self.userEmail.append(userMail)
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
        return userEmail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.emailTextLabel.text = userEmail[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: self.images[indexPath.row]))
        cell.commandTextLabel.text = command[indexPath.row]
        return cell
    }
    
}
