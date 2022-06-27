//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit
import Combine

public protocol ViewState {}

public enum LoadingState {
    case loading, succes, failed, none
}

open class BaseVM: ObservableObject {

    @Published open var loadingState: LoadingState = .none
    public var state = PassthroughSubject<ViewState, Never>()

    required public init() {
        // Intentionally unimplemented
    }

    deinit {
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
