//
//  ViewController.swift
//  BiometricAuthExample
//
//  Created by Ismayil Ismayilov on 28.07.22.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authenticate", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self,
                         action: #selector(didButtonTap),
                         for: .touchUpInside)
    }

    @objc func didButtonTap() {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            let reason = "Please authorized with touch id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { [weak self] success, error in
                
                DispatchQueue.main.async {
                    
                    guard success, error == nil else {
                        
                        let alert = UIAlertController(title: "Failed to Authenticate",
                                                      message: "Please try again",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel))
                        
                        self?.present(alert, animated: true)
                        return
                    }
                    
                    let vc = UIViewController()
                    vc.title = "Welcome"
                    vc.view.backgroundColor = .systemRed
                    self?.present(UINavigationController(rootViewController: vc),
                                  animated: true )
                }
                
            }
        }
        else {
            //do smt
            let alert = UIAlertController(title: "Unavailable",
                                          message: "You can't use this feature",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel))
            
            present(alert, animated: true)
        }
    }

}

