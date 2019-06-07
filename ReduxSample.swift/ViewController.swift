//
//  ViewController.swift
//  ReduxSample.swift
//
//  Created by Yusuke Binsaki on 2019/06/06.
//  Copyright © 2019 Yusuke Binsaki. All rights reserved.
//

import UIKit
import ReSwift

struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}

enum OtherAction: Action {
    case Ok(Int)
    case Err(String)
}

class ViewController: UIViewController, StoreSubscriber {

    @IBOutlet var counterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self) { (state) -> Subscription<CounterState> in
            state.select { $0.counterState }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    func newState(state: CounterState) {
        print("received state=\(state.counter)")
        self.counterLabel.text = "\(state.counter)"
    }

    @IBAction func increaseButtonTapped(_ sender: UIButton) {
        mainStore.dispatch(CounterActionIncrease())
    }

    @IBAction func decreaseButtonTapped(_ sender: UIButton) {
        mainStore.dispatch(CounterActionDecrease())
    }

    @IBAction func otherActionTapped(_ sender: UIButton) {
        mainStore.dispatch(OtherAction.Ok(0))
    }
}
