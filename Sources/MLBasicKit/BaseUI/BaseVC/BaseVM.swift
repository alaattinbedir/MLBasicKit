//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit
import Combine

open class BaseVM {
    public var cancellables = Set<AnyCancellable>()

    required public init() {
        // Intentionally unimplemented
    }

    deinit {
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
