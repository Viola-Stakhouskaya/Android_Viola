//
//  UIViewController.swift
//  VILKa
//
//  Created by Viola Stakhouskaya on 7/28/19.
//  Copyright © 2019 Viola Stakhouskaya. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate(storyboardName: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName)
    }
    
    private static func instantiateFromStoryboardHelper<T>(storyboardName: String) -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
