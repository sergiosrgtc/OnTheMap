//
//  ViewController+AcitivityIndicator.swift
//  OntheMap
//
//  Created by Sergio Costa on 05/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

extension UIViewController {
    

    func ActivityIndicator(isBusy: Bool){
        if isBusy{
            let container: UIView = UIView()
            container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
            container.backgroundColor = .clear
            
            activityView.center = self.view.center
            activityView.startAnimating()
            
            
            container.addSubview(activityView)
            self.view.addSubview(container)
        }else{
            
        }
    }

}
