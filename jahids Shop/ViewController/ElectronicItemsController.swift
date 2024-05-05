//
//  ElectronicsItemController.swift
//  jahids Shop
//
//  Created by jahidul islam on 20/4/24.
//

import UIKit
import SwiftyJSON

class ElectronicItemsController: UIViewController {
    
    @IBOutlet weak var ElectronisCollection: UICollectionView!
    
    let products: [DisplayProduct] = [
        DisplayProduct(id: 1, name: "Charger Fan", description: "The FIFA World Cup is a professional football tournament held between national football teams, organised by FIFA. The tournament has been contested by 32 teams since the 1998 event", discountedPrice: 100.0, originalPrice: 120.0),
        DisplayProduct(id: 2, name: "Air Cooler", description: "Standard Cricket Bat in mid range. The tournament has been contested by 32 teams since the 1998 event",discountedPrice: 75.0, originalPrice: 100.0),
        DisplayProduct(id: 3, name: "MacBook-Air", description: "Standard Hockey Stick in mid range", discountedPrice: 70.0, originalPrice: 80.0),
        DisplayProduct(id: 4, name: "MacBook-Pro", description: "Standard Busket Ball in mid range", discountedPrice: 100.0, originalPrice: 110.0),
        DisplayProduct(id: 5, name: "iPhone 15 Pro Max", description: "Standard Nike Shoes in mid range. this is my favourit shoes. nike Brand ambasador messi, ronaldo and many sports player", discountedPrice: 80.0, originalPrice: 90.0),
        DisplayProduct(id: 6, name: "Samsung S24 Ultra", description: "Standard Adiddas Jersey in mid range", discountedPrice: 90.0, originalPrice: 100.0),
        DisplayProduct(id: 7, name: "Redmi Note 10 Pro", description: "Standard Adiddas Jersey in mid range", discountedPrice: 90.0, originalPrice: 100.0),
        DisplayProduct(id: 8, name: "OnePluse 10 Pro", description: "Standard Adiddas Jersey in mid range", discountedPrice: 90.0, originalPrice: 100.0)
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Electronics Item"
        
        self.ElectronisCollection.dataSource = self
        self.ElectronisCollection.delegate = self
        
        self.ElectronisCollection.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        
        let productNib = UINib(nibName: CellIdentifier.productCell, bundle: nil)
        self.ElectronisCollection.register(productNib, forCellWithReuseIdentifier: CellIdentifier.productCell)
    }
}

extension ElectronicItemsController: UICollectionViewDataSource {
    
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

extension ElectronicItemsController: UICollectionViewDelegateFlowLayout {
    
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
