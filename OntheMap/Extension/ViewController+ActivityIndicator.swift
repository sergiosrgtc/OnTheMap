//
//  ViewController+ActivityView.swift
//  OntheMap
//
//  Created by Sergio Costa on 07/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func configureActivityIndicator()-> UIActivityIndicatorView{
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        
        return activityView
    }
}
