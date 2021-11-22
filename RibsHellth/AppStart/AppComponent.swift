//
//  AppComponent.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import Foundation
import RIBs
// MARK: Setup RootDependency first time when load
class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
