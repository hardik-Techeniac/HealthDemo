//
//  GraphBuilder.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import RIBs

protocol GraphDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class GraphComponent: Component<GraphDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol GraphBuildable: Buildable {
    func build(withListener listener: GraphListener) -> GraphRouting
}

final class GraphBuilder: Builder<GraphDependency>, GraphBuildable {

    override init(dependency: GraphDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: GraphListener) -> GraphRouting {
        let component = GraphComponent(dependency: dependency)
        let viewController = GraphViewController()
        let interactor = GraphInteractor(presenter: viewController)
        interactor.listener = listener
        return GraphRouter(interactor: interactor, viewController: viewController)
    }
}
