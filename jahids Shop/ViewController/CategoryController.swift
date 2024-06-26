//  Created by jahidul islam on 6/3/24.

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Kingfisher
    

class CategoryController: UIViewController {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    //@IBOutlet weak var nCollectionView: UICollectionView!
    
    var populerProducts: [JSON] = [
        
    ]
    
    let products: [DisplayProduct] = [
        DisplayProduct(id: 1, name: "Football", description: "The FIFA World Cup is a professional football tournament held between national football teams, organised by FIFA. The tournament has been contested by 32 teams since the 1998 event", discountedPrice: 100.0, originalPrice: 120.0),
        DisplayProduct(id: 2, name: "Cricket Bat", description: "Standard Cricket Bat in mid range. The tournament has been contested by 32 teams since the 1998 event",discountedPrice: 75.0, originalPrice: 100.0),
        DisplayProduct(id: 3, name: "Hockey Stick", description: "Standard Hockey Stick in mid range", discountedPrice: 70.0, originalPrice: 80.0),
        DisplayProduct(id: 4, name: "Busket Ball", description: "Standard Busket Ball in mid range", discountedPrice: 100.0, originalPrice: 110.0),
        DisplayProduct(id: 5, name: "Nike Shose", description: "Standard Nike Shoes in mid range. this is my favourit shoes. nike Brand ambasador messi, ronaldo and many sports player", discountedPrice: 80.0, originalPrice: 90.0),
        DisplayProduct(id: 6, name: "Adiddas Jersey", description: "Standard Adiddas Jersey in mid range", discountedPrice: 90.0, originalPrice: 100.0)
    ]
    
    var categoryCollection: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Brows products"
        
        self.mCollectionView.dataSource = self
        self.mCollectionView.delegate = self
        
        self.mCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout.init(), animated: true)
        
        let productNib = UINib(nibName: CellIdentifier.productCell, bundle: nil)
        self.mCollectionView.register(productNib, forCellWithReuseIdentifier: CellIdentifier.productCell)
        
        let categoryHolderNib = UINib(nibName: CellIdentifier.categoryHolderCell, bundle: nil)
        self.mCollectionView.register(categoryHolderNib, forCellWithReuseIdentifier: CellIdentifier.categoryHolderCell)
        
        let categoryCellNib = UINib(nibName: CellIdentifier.categoryCell, bundle: nil)
        self.mCollectionView.register(categoryCellNib, forCellWithReuseIdentifier: CellIdentifier.categoryCell)
        
        let sectionHeaderNib = UINib(nibName: CellIdentifier.collectionSectionHeaderView, bundle: nil)
        self.mCollectionView.register(sectionHeaderNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifier.collectionSectionHeaderView)
        
        self.fetchProductCategories()
        self.fetchProducts()
    }

}

extension CategoryController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.populerProducts.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            let categoryHolderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.categoryHolderCell, for: indexPath) as! CategoryHolderCell
            categoryHolderCell.setCategoriesAndReload(cats: self.categoryCollection)
            categoryHolderCell.daligate = self
            return categoryHolderCell
            
        } else {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.productCell, for: indexPath) as! ProductCell
            //let product = self.products[row]
            //cell.setProductInformation(product: product)
            let data = self.populerProducts[indexPath.row]
            
            if let image = data["images"][0].string, let url = URL(string: image) {
                cell.productImageView.kf.setImage(with: url)
            }
            
            if let title = data["title"].string {
                cell.productNameLavel.text = title
            }
            if let descripsion = data["description"].string {
                cell.ProductDescriptionLabel.text = descripsion
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
}

extension CategoryController: UICollectionViewDelegate {
        
    
    
}

extension CategoryController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(width: self.view.frame.width, height: 120.0)
           // return CGSize(width: 120.0, height: 101.0)
        }
        return sizeForItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = mCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifier.collectionSectionHeaderView, for: indexPath) as! CollectionSectionHeaderView
        if indexPath.section == 0 {
            header.headerTitleLavel?.text = "Products Categories"
            
        } else {
            header.headerTitleLavel?.text = "15% Flat Discounts"
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 40.0)
    }
}

extension CategoryController {
    
    func sizeForItem () -> CGSize {
        let screenWidth = self.view.frame.width
        let spacingBetweenItem = 10.0
        let spacingAtEdges = 10.0
        let numberOfItemsInEachRow = 2
        
        let totalSpacing = (spacingAtEdges * 2) + (Double (numberOfItemsInEachRow - 1) * spacingBetweenItem)
        let itemWidth = (screenWidth - totalSpacing) / 2
        
        return CGSize(width: itemWidth, height: 270.0)
    }
}

extension CategoryController {
    func fetchProducts () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.productsUrl
        AF.request(url).responseData { response in
            //debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
            case .success:
                print("Validation Successful")
                
                if let responseData = response.value {
                    do {
                        let json = try JSON (data: responseData)
                        //print(json)
                        if let array = json.array {
                            self.populerProducts = array
                            self.mCollectionView.reloadData()
                        }
                        //print("CategoryCOllection = \(self.categoryCollection)")
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

extension CategoryController {
    
    func fetchProductCategories () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.categoryUrl
        AF.request(url).responseData { response in
            debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
            case .success:
                print("Validation Successful")
                
                if let responseData = response.value {
                    do {
                        let json = try JSON (data: responseData)
                        //print(json)
                        if let array = json.array {
                            self.categoryCollection = array
                            self.mCollectionView.reloadData()
                        }
                        //print("CategoryCOllection = \(self.categoryCollection)")
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

extension CategoryController: CategoryHolderCellDeligate {
    
    func electronicsItemDidSelected() {
        if let electronisController = self.storyboard?.instantiateViewController(withIdentifier: Constans.electronicsItemController) as? ElectronicItemsController {
            self.navigationController?.pushViewController(electronisController, animated: true)
        }
    }
    
    func clothesDidSelected() {
        if let ClothesController = self.storyboard?.instantiateViewController(withIdentifier: Constans.clothesController) as? ClothesController {
            self.navigationController?.pushViewController(ClothesController, animated: true)
        }
    }
    
    func sportsItemDidSelected() {
        if let sportsController = self.storyboard?.instantiateViewController(withIdentifier: Constans.sportsController) as? FurnitureController {
            self.navigationController?.pushViewController(sportsController, animated: true)
        }
    }
}
