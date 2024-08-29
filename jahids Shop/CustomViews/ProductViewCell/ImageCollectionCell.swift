

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var productHolderCollection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.productHolderCollection.dataSource = self
        self.productHolderCollection.delegate = self
        
        let flowlayout = UICollectionViewFlowLayout.init()
        flowlayout.scrollDirection = .horizontal
        self.productHolderCollection.setCollectionViewLayout(flowlayout, animated: true)
        
        let PoductImageCellNib = UINib(nibName: CellIdentifier.imageCell, bundle: nil)
        self.productHolderCollection.register(PoductImageCellNib, forCellWithReuseIdentifier: CellIdentifier.imageCell)
        
        let productViewControllerNib = UINib(nibName: Constans.productViewController, bundle: nil)
        self.productHolderCollection.register(productViewControllerNib, forCellWithReuseIdentifier: Constans.productViewController)
    }

}


extension ImageCollectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = productHolderCollection.dequeueReusableCell(withReuseIdentifier: CellIdentifier.imageCell, for: indexPath) as! ImageCell
        
        if let url = URL(string: ViewDetails.image) {
            cell.ProductViewImage.kf.setImage(with: url)
        }
        
        return cell
    }
    
    
}

extension ImageCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 380.0, height: 250.0)
    }
}
