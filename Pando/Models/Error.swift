//
//  Error.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import Foundation
import Amplify

//TODO: go back into all the do catch, and change the error to be a PandoError
enum PandoError: Error {
    case amplify(AmplifyError)
    case locationPermissionsDenied
    case authenticationError
}
