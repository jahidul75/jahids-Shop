//
//  SearchController.swift
//  jahids Shop
//
//  Created by jahidul islam on 6/3/24.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let products: [product] = [
        product(id: 1, name: "Football", description: "The FIFA World Cup is a professional football tournament held between national football teams, organised by FIFA. The tournament has been contested by 32 teams since the 1998 event", inStock: true),
        product(id: 2, name: "Cricket Bat", description: "Standard Cricket Bat in mid range. The tournament has been contested by 32 teams since the 1998 event", inStock: true),
        product(id: 3, name: "Hockey Stick", description: "Standard Hockey Stick in mid range", inStock: false),
        product(id: 4, name: "Busket Ball", description: "Standard Busket Ball in mid range", inStock: false),
        product(id: 5, name: "Nike Shose", description: "Standard Nike Shoes in mid range. this is my favourit shoes. nike Brand ambasador messi, ronaldo and many sports player", inStock: true),
        product(id: 6, name: "Adiddas Jersey", description: "Standard Adiddas Jersey in mid range", inStock: true)
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
    }
    
    
}


extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
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
        
        let product = self.products[indexPath.row]
        cell.nameLavel.text = product.name
        cell.descriptionLavel.text = product.description
        if product.inStock {
            cell.instockLavel.text = "In Stock"
            cell.instockLavel.textColor = UIColor.green
        } else {
            cell.instockLavel.text = "Stock Out"
            cell.instockLavel.textColor = UIColor.red
        }
        
        let image = UIImage(systemName: "soccerball")?.withRenderingMode(.alwaysTemplate)
        cell.productImage.image = image
        cell.productImage.tintColor = .systemOrange
        
        return cell
    }
}
