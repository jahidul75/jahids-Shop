//
//  LoginViewController.swift
//  jahids Shop
//
//  Created by jahidul islam on 20/2/24.
//

import UIKit
import Alamofire
import MBProgressHUD
import KeychainSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameFaild: UITextField!
    @IBOutlet weak var passwordFaild: UITextField!
    
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoBorderColor = UIColor(named: "theme200") ?? UIColor.systemCyan
        self.logoImageView.ApplyCorner(CornerRadius: 15.0, BorderWidth: 2.0, BorderColor: logoBorderColor)

        // Do any additional setup after loading the view.
        self.title = "Login"
        
        if let email = self.keychain.get("email") {
            self.usernameFaild.text = email
        }
        
        if let password = self.keychain.get("password") {
            self.passwordFaild.text = password
        }
    }
    
    
    @IBAction func onClickLoginButton () {
        
        if validateLoginInfo() {
            let email = self.usernameFaild.text!
            let password = self.passwordFaild.text!
            self.login(email: email, password: password)
        }
        //self.login()
        
    }
    
    func validateLoginInfo () -> Bool {
        
        guard let email = self.usernameFaild.text, email.isValidateEmail() else {
            DisplayAlert(title: "Invalid email", massage: "Please enter a valid email")
            return false
        }
        
        guard let password = self.passwordFaild.text, password.isValidatePassword() else {
            DisplayAlert(title: "password too short", massage: "please enter atleast 6 Charecter password")
            return false
        }
        
        return true
    }
    
    func login (email: String, password: String) {
        let url = RestClient.baseUrl + RestClient.loginUrl
        let LoginRequest = LoginRequest(email: email, password: password)
        let headers: HTTPHeaders = [
            "Content-Type" : "Application/Json"
        ]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request(url, method: .post, parameters: LoginRequest, encoder: JSONParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).responseDecodable(of: LoginResponse.self) { response in
            //debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
                case .success:
                print(response)
                if let responsData = response.value {
                    if let accesToken = responsData.access_token {
                        self.writeToUserDefoults(key: "accessToken", Value: accesToken)
                        
                        self.keychain.set(email, forKey: "email")
                        self.keychain.set(password, forKey: "password")
                        
                        self.navigate()
                    } else if let statusCode = responsData.statusCode, let message = responsData.massage {
                        self.DisplayAlert(title: "Login Failed", massage: message)
                    }
                }
                case let .failure(error):
                    print(error)
            
                }
        }
    }
    
    func navigate () {
        if let currentSceneDelegate = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let sceneDelegate = currentSceneDelegate.delegate as? SceneDelegate, let window = sceneDelegate.window {
                //print(window.rootViewController)
                
              if let tabController =
                    self.storyboard?.instantiateViewController(withIdentifier: Constans.tabController) as? UITabBarController {
                    window.rootViewController = tabController
                }
            }
        }
    }
    
    
    @IBAction func onClickSignUpButton () {
       if let signupController = self.storyboard?.instantiateViewController(withIdentifier: Constans.signupController) as? SignupController {
           //signupController.value = 1
            self.navigationController?.pushViewController(signupController, animated: true)
        }
    }
    
   /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let singupController = segue.destination as? SignupController {
           singupController.value = 3
       }
    }*/

}
