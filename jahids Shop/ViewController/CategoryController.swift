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
    
    @objc func btnOrderAction (_ sender: UIButton) {
        if let cartVC = storyboard?.instantiateViewController(withIdentifier: "OrderController") as? OrderController {
            let data = populerProducts[sender.tag]
            let info = cart(image: "image", title: "title", price: 120)
            cartVC.arr = "jahidul"
            //cartVC.arr.append(contentsOf: "jahidul")
            print("Value Changed tag \(sender.tag)")
        }
        
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
        //let row = indexPath.row
        
        if section == 0 {
            let categoryHolderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.categoryHolderCell, for: indexPath) as! CategoryHolderCell
            categoryHolderCell.setCategoriesAndReload(cats: self.categoryCollection)
            categoryHolderCell.delegate = self
            return categoryHolderCell
            
        } else {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.productCell, for: indexPath) as! ProductCell
            //let product = self.products[row]
            //cell.setProductInformation(product: product)
            cell.ProductCartButton.tag = indexPath.row
            cell.ProductCartButton.addTarget(self, action: #selector(btnOrderAction), for: .touchUpInside)
            let data = self.populerProducts[indexPath.row]
            
            if let image = data["image"].string, let url = URL(string: image) {
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
                let mainPrice = ((price*15)/100) + price
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
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = self.populerProducts[indexPath.row]
        
        if let image = data["image"].string {
            ViewDetails.image = image
        }
        
        if let title = data["title"].string {
            ViewDetails.name = title
        }
        if let descripsion = data["description"].string {
            ViewDetails.descripsion = descripsion
        }
        
        if let price = data["price"].int {
            ViewDetails.price = price
        }
        
        if let productViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
    
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
        
        if screenWidth > 500 {
            let spacingBetweenItem = 10.0
            let spacingAtEdges = 10.0
            let numberOfItemsInEachRow = 4
            
            let totalSpacing = (spacingAtEdges * 4) + (Double (numberOfItemsInEachRow - 1) * spacingBetweenItem)
            let itemWidth = (screenWidth - totalSpacing) / 4
            
            return CGSize(width: itemWidth, height: 270.0)
        } else {
            let spacingBetweenItem = 10.0
            let spacingAtEdges = 10.0
            let numberOfItemsInEachRow = 2
                    
            let totalSpacing = (spacingAtEdges * 2) + (Double (numberOfItemsInEachRow - 1) * spacingBetweenItem)
            let itemWidth = (screenWidth - totalSpacing) / 2
                    
            return CGSize(width: itemWidth, height: 270.0)
        }
        
    }
}

extension CategoryController {
    func fetchProducts () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = "https://fakestoreapi.com/products"
        AF.request(url).responseData { response in
            //debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
            case .success:
                //print("Validation Successful")
                
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
    
    func CategoryDidSelected() {
        if let ClothesController = self.storyboard?.instantiateViewController(withIdentifier: Constans.clothesController) as? CategoryViewController {
            self.navigationController?.pushViewController(ClothesController, animated: true)
        }
    }
}

extension CategoryController {
    

}
