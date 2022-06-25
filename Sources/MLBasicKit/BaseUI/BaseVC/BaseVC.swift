//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit
import Combine

public protocol ViewModelData {}

open class BaseVC<VM>: BaseDataVC where VM: BaseVM {
    public lazy var viewModel: VM = VM()
    private var stateSubscriber: AnyCancellable?

    open override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewStateChanges()
        setResources()
        setAccessibilityIdentifiers()
        print("*** \(String(describing: type(of: self))) initialized")
    }

    private func subscribeViewStateChanges() {
        stateSubscriber = viewModel.state.sink { [weak self] state in
            self?.onStateChanged(state)
        }
    }

    open func onStateChanged(_ state: ViewState) {
        // Intentionally unimplemented
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
        stateSubscriber?.cancel()
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
