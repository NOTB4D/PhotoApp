//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 18.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    



}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.emailTextLabel.text = "eser"
        cell.commandTextLabel.text = "Cok Güzel Oldu"
        return cell
    }
    
}
