//
//  RepoListState.swift
//  ReduxSample.swift
//
//  Created by Yusuke Binsaki on 2019/06/09.
//  Copyright © 2019 yuu. All rights reserved.
//

import ReSwift
import ReSwiftThunk
import Octokit

struct RepoListState: StateType {
    var loading: Bool = false
    var repositories: [Repository] = []
}

extension RepoListState {
    enum Action: ReSwift.Action {
    case loading
    case repositories([Repository])
    case networkError(Error)
    }

    static func reducer(action: RepoListState.Action, state: RepoListState?) -> RepoListState {
        var state = state ?? RepoListState()

        switch action {
        case .loading:
            state.loading = true
            print("now loading")
        case .repositories(let repos):
            state.repositories = repos
            state.loading = false
        case .networkError(let err):
            print(err)
            state.loading = false
        }

        return state
    }

    static let fetchRepositories = Thunk<AppState> { (dispatch, getState) in
        guard let state = getState() else { return }
        guard case let .loggedIn(configuration) = state.auth else { return }

        let _ = Octokit(configuration).repositories { (response) in
            switch response {
            case let .success(repositories):
                DispatchQueue.main.async {
                    dispatch(RepoListState.Action.repositories(repositories))
                }
            case let .failure(err):
                DispatchQueue.main.async {
                    dispatch(RepoListState.Action.networkError(err))
                    print(err)
                }
            }
        }

        dispatch(Action.loading)
    }
}
