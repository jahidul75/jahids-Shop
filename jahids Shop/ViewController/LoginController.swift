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
        
        usernameFaild.text = "jahidulcmt86@gmail.com"
        passwordFaild.text = "12345678"
        // Do any additional setup after loading the view.
        self.title = "Login"
        
        /*if let email = self.keychain.get("email") {
            self.usernameFaild.text = email
        }*/
        
        /*if let password = self.keychain.get("password") {
            self.passwordFaild.text = password
        }*/
    }
    
    
    @IBAction func onClickLoginButton () {
        
        /*if validateLoginInfo() {
            let email = self.usernameFaild.text!
            let password = self.passwordFaild.text!
            self.login(email: email, password: password)
        }*/
        self.navigate()
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
    
    /*func login (email: String, password: String) {
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
                //print(response)
                if let responsData = response.value {
                    if let accesToken = responsData.access_token {
                        self.writeToUserDefoults(key: "accessToken", Value: accesToken)
                        
                        self.keychain.set(email, forKey: "email")
                        self.keychain.set(password, forKey: "password")
                        
                        self.navigate()
                    } else if let message = responsData.massage {
                        self.DisplayAlert(title: "Login Failed", massage: message)
                    }
                }
                case let .failure(error):
                    print(error)
            
                }
        }
    }*/
    
    func navigate () {
        guard let userName = usernameFaild.text else {return}
        guard let password = passwordFaild.text else {return}
        
        if userName.count >= 10 && password.count >= 6 {
            if let currentSceneDelegate = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let sceneDelegate = currentSceneDelegate.delegate as? SceneDelegate, let window = sceneDelegate.window {
                    //print(window.rootViewController)
                    
                  if let tabController =
                        self.storyboard?.instantiateViewController(withIdentifier: Constans.tabController) as? UITabBarController {
                        window.rootViewController = tabController
                    }
                }
            }
        }else if userName.count < 10 {
            let aler = UIAlertController(title: "username invalid", message: "Please enter valid username", preferredStyle: .alert)
            aler.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(aler, animated: true)
        }else if password.count < 6 {
            let alert = UIAlertController(title: "your password to shot", message: "Please enter minium 6 digit password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
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
