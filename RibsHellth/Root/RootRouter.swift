//
//  RootRouter.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import RIBs
import RxSwift
protocol RootInteractable: Interactable ,GraphListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    private let graphBuilder: GraphBuildable
    private var graphRouting: GraphRouting?
     init(interactor: RootInteractable, viewController: RootViewControllable ,graphBuilder: GraphBuildable) {
         self.graphBuilder = graphBuilder
         super.init(interactor: interactor, viewController: viewController)
         interactor.router = self
    }
    override func didLoad() {
        super.didLoad()
        route()
    }
    
    func route() {
     routetoGraphVC()
    }
    func routetoGraphVC()
    {
        let graphVCRouting = graphBuilder.build(withListener: interactor)
        self.graphRouting = graphVCRouting
        attachChild(graphVCRouting)
        
        let navigationController = UINavigationController(root: graphVCRouting.viewControllable)
        viewController.present(viewController: navigationController)
    }
}
