//
//  RootBuilder.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import RIBs
import RxSwift
protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> ,GraphDependency{

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    // MARK: Setup when launch and Next screen as per Ribs
    func build() -> LaunchRouting {
        
        let component = RootComponent(dependency: dependency)
        let GraphBuild = GraphBuilder(dependency: component)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(interactor: interactor, viewController: viewController, graphBuilder: GraphBuild)
    }
}
