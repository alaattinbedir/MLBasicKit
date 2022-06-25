//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit

public protocol ViewModelData {}

open class BaseVC<VM>: BaseDataVC where VM: BaseVM {
    public lazy var viewModel: VM = VM()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setResources()
        setAccessibilityIdentifiers()
        print("*** \(String(describing: type(of: self))) initialized")
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    open func setResources() {
        // Intentionally unimplemented
    }

    open func setAccessibilityIdentifiers() {
        // Intentionally unimplemented
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
