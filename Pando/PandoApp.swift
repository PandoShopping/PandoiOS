//
//  PandoApp.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct PandoApp: App {
    var body: some Scene {
        WindowGroup {
            SessionView()
        }
    }
    init() {
        configureAmplify()
    }
    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Successfully configured Amplify")
        } catch {
            print("Failed to initialize Amplify", error)
        }
    }
}
