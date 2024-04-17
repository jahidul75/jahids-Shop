//
//  CareateProductController.swift
//  jahids Shop
//
//  Created by jahidul islam on 14/4/24.
//

import UIKit
import ActionKit
import Alamofire
import MBProgressHUD

class CreateProductController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var pickImageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Creat A Product"
        
        self.pickImageButton.addControlEvent(.touchUpInside) {
            self.showImagePickerDialog()
        }
        
    }
    
    func showImagePickerDialog () {
        let controller = UIAlertController(title: "Select Image", message: "Select an image", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { action in
            let controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.delegate = self
            controller.allowsEditing = true
            self.present(controller, animated: true)
        }
        let GalleryAction = UIAlertAction(title: "Open Gallery", style: .default) { action in
            let controller = UIImagePickerController()
            controller.sourceType = .photoLibrary
            controller.delegate = self
            controller.allowsEditing = true
            self.present(controller, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        controller.addAction(cameraAction)
        controller.addAction(GalleryAction)
        controller.addAction(cancelAction)
        
        self.present(controller, animated: true)
    }

}

extension CreateProductController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        picker.dismiss(animated: true)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.productImageView.image = image
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.uploadImageToServer(image: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User cancelled image picker")
        picker.dismiss(animated: true)
    }
    
    func uploadImageToServer (image: UIImage) {
        
        guard let imageData = image.pngData() else {
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.photoUploadUrl
        let token = self.readFromUserDefoults(key: "accessToken", defaultValue: "") ?? ""
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + token
        ]
        
        
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "file")
        }, to: url, usingThreshold: .max, method: .post, headers: headers, interceptor: nil, fileManager: FileManager.default, requestModifier: nil).responseDecodable(of: FileUploadeResponse.self) { response in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
                case .success:
                    print("File Upload Successful")
                
                if let fileResponse = response.value {
                    print(fileResponse)
                }
                
                case let .failure(error):
                    print(error)
                }
        }
    }
}
