//
//  ProductViewController.swift
//  jahids Shop
//
//  Created by jahidul islam on 20/5/24.
//

import UIKit

class ProductViewController: UIViewController {
    
    let details: [detail] = [
        detail(id: 1, name: "comfortable gaming chair", descripsion: "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though", price: 100, inStock: true),
        detail(id: 1, name: "comfortable gaming chair", descripsion: "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though", price: 100, inStock: true)
    ]
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var productViewCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productViewCollection.dataSource = self
        self.productViewCollection.delegate = self
        
        self.productViewCollection.setCollectionViewLayout(UICollectionViewFlowLayout.init(), animated: true)
        
        let detailsNib = UINib(nibName: CellIdentifier.detailsCell, bundle: nil)
        self.productViewCollection.register(detailsNib, forCellWithReuseIdentifier: CellIdentifier.detailsCell)
        
        let collectionNib = UINib(nibName: CellIdentifier.imageCollectionCell, bundle: nil)
        self.productViewCollection.register(collectionNib, forCellWithReuseIdentifier: CellIdentifier.imageCollectionCell)
    
    }
}

extension ProductViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.row
        
        if section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.imageCollectionCell, for: indexPath) as! ImageCollectionCell
            cell.productHolderCollection.reloadData()
            
            return cell
            
        } else {
            let Dcell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.detailsCell, for: indexPath) as! DetailsCell
            
            let strokeEffect: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: UIColor.red,
            ]
            
            let price = ViewDetails.price * 10
            let mainPrice = ((price*15)/100) + price
            let originalPrice = NSAttributedString(string: "TK " + String(mainPrice), attributes: strokeEffect)
            let finalAttributedString = NSMutableAttributedString()
            finalAttributedString.append(originalPrice)
            finalAttributedString.append(NSAttributedString(string: " TK "))
            finalAttributedString.append(NSAttributedString(string: String(price)))
                    
        
            Dcell.nameLavel.text = ViewDetails.name
            Dcell.descriptionLavel.text = ViewDetails.descripsion
            Dcell.priceLavel.attributedText = finalAttributedString

            return Dcell
        }
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.row
        if section == 0 {
            return CGSize(width: self.view.frame.width, height: 300.0)
        }
            
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
}
