//
//  CategoryHolderCell.swift
//  jahids Shop
//
//  Created by jahidul islam on 3/4/24.
//

import UIKit
import Foundation
import SwiftUI
import SwiftyJSON
import Kingfisher
import Alamofire

protocol CategoryHolderCellDeligate: AnyObject {
    func clothesDidSelected ()
    func electronicsItemDidSelected ()
    func sportsItemDidSelected()
}

protocol CategorysTitle: AnyObject {
    func changeFirstItemTitle(data: JSON)
}

class CategoryHolderCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    weak var daligate: CategoryHolderCellDeligate?
    weak var ChangeTitle: CategorysTitle?
    
    var categories: [JSON] = [
        
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = true
        
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        
        self.categoryCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        let categoryCellNib = UINib(nibName: CellIdentifier.categoryCell, bundle: nil)
        self.categoryCollectionView.register(categoryCellNib, forCellWithReuseIdentifier: CellIdentifier.categoryCell)
        
        let categoryControllerNib = UINib(nibName: Constans.categoryController, bundle: nil)
        self.categoryCollectionView.register(categoryControllerNib, forCellWithReuseIdentifier: Constans.categoryController)
        
    }
    
    func setCategoriesAndReload (cats: [JSON]) {
        self.categories = cats
        self.categoryCollectionView.reloadData()
    }

}

extension CategoryHolderCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CategoryCount = \(categories.count)")
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.categoryCell, for: indexPath) as! CategoryCell
        
        let data = self.categories[indexPath.row]
        
        
        if let name = data["name"].string {
            cell.categoryNameLavel.text = name
        }
        
        if let image = data["image"].string, let url = URL(string: image) {
            cell.CategoryImageView.kf.setImage(with: url)
        }
            
        
        //cell.categoryNameLavel.text = categories[indexPath.row]
        cell.categoryNameLavel.ApplyCorner(CornerRadius: 10.0, BorderWidth: 0.0, BorderColor: .clear)
        cell.CategoryImageView.ApplyCorner(CornerRadius: 10.0, BorderWidth: 2.0, BorderColor: .systemRed)
        
        return cell
    }
    
}

extension CategoryHolderCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120.0, height: 101.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}

extension CategoryHolderCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            daligate?.clothesDidSelected()
        }
        else if indexPath.row == 1 {
            daligate?.electronicsItemDidSelected()
        }
        else if indexPath.row == 2 {
            daligate?.sportsItemDidSelected()
        }
        
    }
}

