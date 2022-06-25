//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit
import Combine

public protocol ViewState {}

open class BaseVM {

    public var state = PassthroughSubject<ViewState, Never>()

    required public init() {
        // Intentionally unimplemented
    }

    deinit {
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
