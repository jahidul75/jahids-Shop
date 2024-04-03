//
//  SettingsController.swift
//  jahids Shop
//
//  Created by jahidul islam on 6/3/24.
//

import UIKit

class SettingsController: UIViewController {
    
    var items = ["My Profile", "Wishlist","My Orders","Settings","Logout"]
    @IBOutlet weak var mTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "settings"
        
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
    }
}


extension SettingsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        if let mcell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            //as? UITableViewCell
            cell = mcell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let profileController =
                self.storyboard?.instantiateViewController(withIdentifier: Constans.ProfileController) as? ProfileController {
                self.navigationController?.pushViewController(profileController, animated: true)
            }
        }
    }
}
