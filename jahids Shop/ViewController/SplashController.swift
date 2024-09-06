//  Created by jahidul islam on 18/2/24.

import UIKit

class SplashController: UIViewController {
    
    @IBOutlet var splashImage: UIImageView!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.hello.text = "Jahid's Shop"
        
        self.splashImage.ApplyCorner(CornerRadius: 25.0, BorderWidth: 0.0, BorderColor: .clear)
        
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(makeTransition), userInfo: nil, repeats: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        super.viewDidDisappear(animated)
    }
    
    @objc func makeTransition () {
        print("Timer ended")
        self.timer?.invalidate()
        
        // window connect to logincontroller
        if let currentSceneDelegate = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let sceneDelegate = currentSceneDelegate.delegate as? SceneDelegate, let window = sceneDelegate.window {
                //print(window.rootViewController)
                
              if let authViewController =
                    self.storyboard?.instantiateViewController(withIdentifier: Constans.authNavigationController) as? UINavigationController {
                    window.rootViewController = authViewController
                }
            }
        }
    }

}

