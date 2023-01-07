//
//  SessionView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI
import Amplify
import Combine

//should this read from a shared DisplayState? 
struct SessionView: View {

    @StateObject var userState: UserState = .init()
    @State var isSignedIn: Bool = false
    @State var tokens: Set<AnyCancellable> = []

    var body: some View {
        StartingView()
            .environmentObject(userState) //supplies userState to the view hierarchy
            .onAppear {
                Task { await getCurrentSession() }
                observeSession()
            }
    }
}


extension SessionView {
    //TODO: modify this to use the second method: https://www.youtube.com/watch?v=IbxBRzTBeC0&ab_channel=StewartLynch
    @ViewBuilder
    func StartingView() -> some View {
        if isSignedIn {
            LocationRequestView()
        } else {
            LoginView()
        }
    }

    func getCurrentSession() async {
        do {
            //returns the current session on the device
            let session = try await Amplify.Auth.fetchAuthSession()
            DispatchQueue.main.async {
                self.isSignedIn = session.isSignedIn
            }
            guard session.isSignedIn else { return }

            let authUser = try await Amplify.Auth.getCurrentUser()
            self.userState.userId = authUser.userId
            self.userState.username = authUser.username

            let user = try await Amplify.DataStore.query(User.self, byId: authUser.userId)

            if let existingUser = user {
                print ("this is the \(existingUser)")
            } else {
                let newUser = User(id: authUser.userId, username: authUser.username)
                let savedUser = try await Amplify.DataStore.save(newUser)
                print(savedUser)
            }

        } catch {
            print (error)
        }
    }

    ///subscribe to observe sign in state, then updates UI to reflect that state
    func observeSession() {
        //publishes Auth events
        Amplify.Hub.publisher(for: .auth)
            .receive(on: DispatchQueue.main)
            .sink { payload in
                switch payload.eventName {
                case HubPayload.EventName.Auth.signedIn:
                    self.isSignedIn = true
                    Task { await getCurrentSession() }
                case HubPayload.EventName.Auth.signedOut, HubPayload.EventName.Auth.sessionExpired:
                    self.isSignedIn = false
                default:
                    break
                }
            }.store(in: &tokens)
    }
}


struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
