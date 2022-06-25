//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit

open class BaseDataVC: UIViewController {
    open var data: ViewModelData? {
        didSet { dataUpdated() }
    }

    open func getNavVC() -> UINavigationController? {
        nil
    }

    open func dataUpdated() {
        // Intentionally unimplemented
    }
}
