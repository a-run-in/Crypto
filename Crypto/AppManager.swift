//
//  AppManager.swift
//  Crypto
//
//  Created by Arun on 17/10/24.
//

import UIKit

class AppManager{
    
    func startupController() -> UIViewController{
        let viewModel = CTHomeLandingVM()
        let viewcontroller = CTHomeLandingVC(viewModel: viewModel)
        viewModel.setDelegate(viewcontroller)
        return viewcontroller
    }
    
}
