//
//  LoginViewController.swift
//  jahids Shop
//
//  Created by jahidul islam on 20/2/24.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoBorderColor = UIColor(named: "theme200") ?? UIColor.systemCyan
        self.logoImageView.ApplyCorner(CornerRadius: 15.0, BorderWidth: 2.0, BorderColor: logoBorderColor)

        // Do any additional setup after loading the view.
        self.title = "Login"
    }
    

    /*
    // MARK: - Navigation
     
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickLoginButton () {
        self.login()
        
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
    func login () {
        
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
