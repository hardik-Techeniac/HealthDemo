//
//  GraphInteractor.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import RIBs
import RxSwift
import RxCocoa

protocol GraphRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol GraphPresentable: Presentable {
    var listener: GraphPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol GraphListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class GraphInteractor: PresentableInteractor<GraphPresentable>, GraphInteractable, GraphPresentableListener {

    weak var router: GraphRouting?
    weak var listener: GraphListener?
    var graphModel: BehaviorRelay<[ChartModel]> = BehaviorRelay.init(value: [])
    // TODO: Add additional dependencies to constructor. Do not perform any logic in constructor.
    override init(presenter: GraphPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
        // TODO: Fetch All data and bind to second view listerner for passing data
        GraphDataManager.fetchAllDayGraphData().bind(to: graphModel).disposeOnDeactivate(interactor: self)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
