//
//  ProfileController.swift
//  jahids Shop
//
//  Created by jahidul islam on 7/3/24.
//

import UIKit
import ActionKit
import Alamofire
import MBProgressHUD
import Kingfisher

class ProfileController: UIViewController {
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var notifySwitch: UISwitch!
    @IBOutlet weak var notifyLavel: UILabel!
    @IBOutlet weak var nameLavel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "My Profile"
        
        self.profilePhotoImageView.ApplyCorner(CornerRadius: self.profilePhotoImageView.frame.width/2.0, BorderWidth: 0.5, BorderColor: .darkGray)
        
        self.notifySwitch.addControlEvent(.valueChanged) {
            print("Switch --> \(self.notifySwitch.isOn)")
            if self.notifySwitch.isOn {
                self.notifyLavel.text = "Notify me When added my favourit product"
            } else {
                self.notifyLavel.text = "Don't Notify me"
            }
        }
        
        /*let singleTabGestureRecognizer = UITapGestureRecognizer () {
            self.view.backgroundColor = self.getRendomColor()
        }*/
        self.notifyLavel.isUserInteractionEnabled = true
        //self.notifySwitch.addGestureRecognizer(singleTabGestureRecognizer)
        
        self.fetchUserProfile()
        
    }
    
    func getRendomColor () -> UIColor {
        return UIColor(red: getRendomNumber(), green: getRendomNumber(), blue: getRendomNumber(), alpha: 1.0)
    }
    
    func getRendomNumber () -> Double {
        return Double(arc4random() % 255) / 255.0
    }
    
    func fetchUserProfile () {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.profileUrl
        let token = self.readFromUserDefoults(key: "accessToken", defaultValue: "") ?? ""
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + token
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseDecodable(of: profileResponse.self) { response in
            
            debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
            case .success:
                print("Validation Successful")
                
                if let profile = response.value {
                    self.updateUI(profile: profile)
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func updateUI (profile: profileResponse) {
        
        self.nameLavel.text = profile.name
        if let url = URL(string: profile.avatar) {
            self.profilePhotoImageView.kf.setImage(with: url)
        }
        
    }
    

}
