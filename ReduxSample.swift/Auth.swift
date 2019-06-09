//
//  Auth.swift
//  ReduxSample.swift
//
//  Created by Yusuke Binsaki on 2019/06/09.
//  Copyright © 2019 yuu. All rights reserved.
//

import ReSwift
import Octokit

enum AuthState: StateType {
    case loggedIn(TokenConfiguration)
    case loggedOut
}
