//
//  OrderController.swift
//  jahids Shop
//
//  Created by jahidul islam on 6/3/24.
//

import UIKit
import SwiftyJSON
import Kingfisher
import MBProgressHUD
import Alamofire

class OrderController: UIViewController {
    
    @IBOutlet weak var OrderBUtton: UIButton!
    @IBOutlet weak var DeleveryFeeLavel: UILabel!
    @IBOutlet weak var TotalAmountLavel: UILabel!
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    /*var Orders: [JSON] = [
        
    ]*/
    
    let products: [DisplayProduct] = [
        DisplayProduct(id: 1, name: "Football", description: "The FIFA World Cup is a professional football tournament held between national football teams, organised by FIFA. The tournament has been contested by 32 teams since the 1998 event", discountedPrice: 100.0, originalPrice: 120.0),
        DisplayProduct(id: 2, name: "Cricket Bat", description: "Standard Cricket Bat in mid range. The tournament has been contested by 32 teams since the 1998 event",discountedPrice: 75.0, originalPrice: 100.0),
        DisplayProduct(id: 3, name: "Hockey Stick", description: "Standard Hockey Stick in mid range", discountedPrice: 70.0, originalPrice: 80.0),
        DisplayProduct(id: 4, name: "Busket Ball", description: "Standard Busket Ball in mid range", discountedPrice: 100.0, originalPrice: 110.0),
        DisplayProduct(id: 5, name: "Nike Shose", description: "Standard Nike Shoes in mid range. this is my favourit shoes. nike Brand ambasador messi, ronaldo and many sports player", discountedPrice: 80.0, originalPrice: 90.0),
        DisplayProduct(id: 6, name: "Adiddas Jersey", description: "Standard Adiddas Jersey in mid range", discountedPrice: 90.0, originalPrice: 100.0),
        DisplayProduct(id: 6, name: "Premium soccers ball", description: "premium quality Fifa world cup 2022 official soccers ball. waitght 100 gm.", discountedPrice: 90.0, originalPrice: 100.0)
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderCollectionView.dataSource = self
        self.orderCollectionView.delegate = self
        
        self.orderCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        
        let ordersCellNib = UINib(nibName: CellIdentifier.orderCell, bundle: nil)
        self.orderCollectionView.register(ordersCellNib, forCellWithReuseIdentifier: CellIdentifier.orderCell)
        
        let orderControllerNib = UINib(nibName: Constans.orderController, bundle: nil)
        self.orderCollectionView.register(orderControllerNib, forCellWithReuseIdentifier: Constans.orderController)
        
        let sectionHeaderNib = UINib(nibName: CellIdentifier.collectionSectionHeaderView, bundle: nil)
        self.orderCollectionView.register(sectionHeaderNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifier.collectionSectionHeaderView)
        
        self.navigationItem.title = "My Orders"
        self.OrderBUtton.ApplyCorner(CornerRadius: 10.0, BorderWidth: 0.0, BorderColor: .clear)
        
        //self.fetchProductCategories()
    }
    
    /*func setCategoriesAndReload (cats: [JSON]) {
        self.Orders = cats
        self.orderCollectionView.reloadData()
    }*/

}

extension OrderController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.orderCell, for: indexPath) as! OrderCell
        let product = self.products[indexPath.row]
        cell.setOrderInformation(product: product)
        
        return cell
    }
    
    
}

extension OrderController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = self.view.frame.width
        
        let totalSpacing = 10.0
        let itemWidth = screenWidth - totalSpacing
        
        return CGSize(width: itemWidth, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 0.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = orderCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifier.collectionSectionHeaderView, for: indexPath) as! CollectionSectionHeaderView
        
        if indexPath.section == 0 {
            header.headerTitleLavel?.text = "Your Save Orders"
        }

        
        return header
    }
}

extension OrderController {
    
    /*func fetchProductCategories () {
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
                            self.Orders = array
                            self.orderCollectionView.reloadData()
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
    }*/
}

// First Category Items Contol

