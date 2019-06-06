//
//  ViewController.swift
//  ReduxSample.swift
//
//  Created by Yusuke Binsaki on 2019/06/06.
//  Copyright © 2019 Yusuke Binsaki. All rights reserved.
//

import UIKit
import ReSwift

struct AppState: StateType {
    var counter: Int = 0
}
struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}

func counterReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case _ as CounterActionIncrease:
        state.counter += 1
    case _ as CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }

    return state
}

class ViewController: UIViewController, StoreSubscriber {

    @IBOutlet var counterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    func newState(state: AppState) {
        self.counterLabel.text = "\(state.counter)"
    }

    @IBAction func increaseButtonTapped(_ sender: UIButton) {
        mainStore.dispatch(CounterActionIncrease())
    }

    @IBAction func decreaseButtonTapped(_ sender: UIButton) {
        mainStore.dispatch(CounterActionDecrease())
    }
}
