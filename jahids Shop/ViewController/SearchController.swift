//
//  SearchController.swift
//  jahids Shop
//
//  Created by jahidul islam on 6/3/24.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import Alamofire
import Kingfisher

class SearchController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let products: [product] = [
        product(id: 1, name: "Football", description: "1200.00 TK", inStock: true),
        product(id: 2, name: "Cricket Bat", description: "750.00 TK", inStock: true),
        product(id: 3, name: "Hockey Stick", description: "769.00 TK", inStock: false),
        product(id: 4, name: "Busket Ball", description: "908.00 TK", inStock: false),
        product(id: 5, name: "Nike Shose", description: "1290.00 Tk", inStock: true),
        product(id: 6, name: "Adiddas Jersey", description: "756.00 TK", inStock: true),
        product(id: 7, name: "Busket Ball", description: "908.00 Tk", inStock: false),
        product(id: 8, name: "Nike Shose", description: "1290.00 Tk", inStock: true),
        product(id: 9, name: "Adiddas Jersey", description: "756.00 Tk", inStock: true)
    ]
    
    var searchProducts: [JSON] = [
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Search Products"
        
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        
        self.mTableView.register(UINib(nibName: CellIdentifier.searchCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.searchCell)
        
        self.mTableView.estimatedRowHeight = 85.0
        self.mTableView.rowHeight = UITableView.automaticDimension
        
        fetchSearchProducts()
    }
    
    
}


extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchProducts.count
    }
    
    
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    } */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: SearchCell!
        if let mcell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchCell)  as? SearchCell {
            //as? UITableViewCell
            cell = mcell
        }
        
        /*let product = self.products[indexPath.row]
        cell.nameLavel.text = product.name
        cell.priceLavel.text = product.description
        if product.inStock {
            cell.instockLavel.text = "In Stock"
            cell.instockLavel.textColor = UIColor.systemGreen
        } else {
            cell.instockLavel.text = "Stock Out"
            cell.instockLavel.textColor = UIColor.red
        }
        
        let image = UIImage(systemName: "soccerball")?.withRenderingMode(.alwaysTemplate)
        cell.productImage.image = image
        cell.productImage.tintColor = .systemOrange*/
        let product = self.searchProducts[indexPath.row]
        
        if let name = product["title"].string {
            cell.nameLavel.text = name
        }
        if let price = product["price"].int {
            cell.priceLavel.text = String(price) + ".00 TK"
        }
        if let image = product["images"][0].string, let url = URL(string: image) {
            cell.productImage.kf.setImage(with: url)
        }
        
        return cell
    }
}

extension SearchController {
    func fetchSearchProducts () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.productsUrl
        AF.request(url).responseData { response in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
            case .success:
                print("search Validation Successful")
                
                if let responseData = response.value {
                    do {
                        let json = try JSON (data: responseData)
                        
                        if let array = json.array {
                            self.searchProducts = array
                            self.mTableView.reloadData()
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
