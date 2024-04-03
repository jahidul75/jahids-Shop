//  Created by jahidul islam on 18/2/24.

import UIKit

class SplashController: UIViewController {
    
    @IBOutlet var hello: UILabel!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.hello.text = "Jahid's Shop"
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(makeTransition), userInfo: nil, repeats: false)
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

