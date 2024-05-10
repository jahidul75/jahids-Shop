//
//  ElectronicsItemController.swift
//  jahids Shop
//
//  Created by jahidul islam on 20/4/24.
//

import UIKit
import SwiftyJSON
import Alamofire
import MBProgressHUD
import Kingfisher

class ElectronicItemsController: UIViewController {
    
    @IBOutlet weak var ElectronisCollection: UICollectionView!
    
    var electronis: [JSON] = [
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Electronics Item"
        
        self.ElectronisCollection.dataSource = self
        self.ElectronisCollection.delegate = self
        
        self.ElectronisCollection.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        
        let productNib = UINib(nibName: CellIdentifier.productCell, bundle: nil)
        self.ElectronisCollection.register(productNib, forCellWithReuseIdentifier: CellIdentifier.productCell)
        
        self.fetchElectronisProducts()
    }
}

extension ElectronicItemsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.electronis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.productCell, for: indexPath) as! ProductCell
        
        let data = self.electronis[indexPath.row]
        
       if let title = data["title"].string {
            cell.productNameLavel.text = title
        }
        if let descripsion = data["description"].string {
            cell.ProductDescriptionLabel.text = descripsion
        }
        if let image = data["images"][0].string, let url = URL(string: image) {
            cell.productImageView.kf.setImage(with: url)
        }
        if var price = data["price"].int {
            let strokeEffect: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: UIColor.red,
            ]
            
            price *= 10
            var mainPrice = ((price*15)/100) + price
            let originalPrice = NSAttributedString(string: "TK " + String(mainPrice), attributes: strokeEffect)
            let finalAttributedString = NSMutableAttributedString()
            finalAttributedString.append(originalPrice)
            finalAttributedString.append(NSAttributedString(string: " TK "))
            finalAttributedString.append(NSAttributedString(string: String(price)))
            
            cell.productPriceLabel.attributedText = finalAttributedString
        }
        
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
        
        
        return CGSize(width: finalSize, height: 270.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}


extension ElectronicItemsController {
    func fetchElectronisProducts () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.secondCategoryUrl
        AF.request(url).responseData { response in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
            case .success:
                print("Validation Successful")
                
                if let responseData = response.value {
                    do {
                        let json = try JSON (data: responseData)
                        
                        if let array = json.array {
                            self.electronis = array
                            self.ElectronisCollection.reloadData()
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
