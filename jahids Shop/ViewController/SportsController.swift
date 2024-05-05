//
//  SportsController.swift
//  jahids Shop
//
//  Created by jahidul islam on 4/5/24.
//

import UIKit

class SportsController: UIViewController {
    
    @IBOutlet weak var sportsCollection: UICollectionView!
    
    let products: [DisplayProduct] = [
        DisplayProduct(id: 1, name: "Football", description: "The FIFA World Cup is a professional football tournament held between national football teams, organised by FIFA. The tournament has been contested by 32 teams since the 1998 event", discountedPrice: 100.0, originalPrice: 120.0),
        DisplayProduct(id: 2, name: "Cricket Bat", description: "Standard Cricket Bat in mid range. The tournament has been contested by 32 teams since the 1998 event",discountedPrice: 75.0, originalPrice: 100.0),
        DisplayProduct(id: 3, name: "Hockey Stick", description: "Standard Hockey Stick in mid range", discountedPrice: 70.0, originalPrice: 80.0),
        DisplayProduct(id: 4, name: "Busket Ball", description: "Standard Busket Ball in mid range", discountedPrice: 100.0, originalPrice: 110.0),
        DisplayProduct(id: 5, name: "Nike Shose", description: "Standard Nike Shoes in mid range. this is my favourit shoes. nike Brand ambasador messi, ronaldo and many sports player", discountedPrice: 80.0, originalPrice: 90.0),
        DisplayProduct(id: 6, name: "Adiddas Jersey", description: "Standard Adiddas Jersey in mid range", discountedPrice: 90.0, originalPrice: 100.0)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sports Item"
        self.sportsCollection.dataSource = self
        self.sportsCollection.delegate = self
        
        self.sportsCollection.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        
        let ProductNib = UINib(nibName: CellIdentifier.productCell, bundle: nil)
        self.sportsCollection.register(ProductNib, forCellWithReuseIdentifier: CellIdentifier.productCell)
    }
}

extension SportsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.productCell, for: indexPath) as! ProductCell
        let product = self.products[indexPath.row]
        cell.setProductInformation(product: product)
        
        return cell
    }
}

extension SportsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screensize = self.view.frame.width
        let spaceEdge = 10.0
        let spaceEdgeItem = 10.0
        let totalItem = 2
        
        let totalSpacing = (spaceEdge * 2) + (Double(totalItem-1) * spaceEdgeItem)
        let finalSize = (screensize - totalSpacing) / 2
        
        
        return CGSize(width: finalSize, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}
