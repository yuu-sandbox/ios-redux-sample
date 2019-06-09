//
//  ViewController.swift
//  ReduxSample.swift
//
//  Created by Yusuke Binsaki on 2019/06/06.
//  Copyright © 2019 Yusuke Binsaki. All rights reserved.
//

import UIKit
import ReSwift
import SVProgressHUD

class ViewController: UIViewController, StoreSubscriber {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        mainStore.dispatch(RepoListState.fetchRepositories)
    }

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    func newState(state: AppState) {
        if state.repoList.loading {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainStore.state.repoList.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepoListViewCell
        cell.repoNameLabel.text = mainStore.state.repoList.repositories[indexPath.row].name
        return cell
    }
}
