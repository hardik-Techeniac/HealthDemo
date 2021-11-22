//
//  GraphRouter.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import RIBs

protocol GraphInteractable: Interactable {
    var router: GraphRouting? { get set }
    var listener: GraphListener? { get set }
}

protocol GraphViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class GraphRouter: ViewableRouter<GraphInteractable, GraphViewControllable>, GraphRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: GraphInteractable, viewController: GraphViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
