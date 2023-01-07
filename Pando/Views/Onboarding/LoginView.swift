//
//  LoginView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI
import Amplify

struct LoginView: View {
    //is this private necessary, in here + the other views
    @State private var username: String = ""
    @State private var password: String = ""
    @State var shouldShowSignUp: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                Button {
                    Task { await login() }
                } label: {
                    Text("Continue")
                }
                Button {
                    //action
                } label: {
                    Text("Login with Google")
                }
                Button {
                    //action
                } label: {
                    Text("Login with Apple")
                }
                Button {
                    shouldShowSignUp = true
                } label: {
                    Text("Don't have an account? Sign Up")
                }


            }
            .navigationDestination(isPresented: $shouldShowSignUp) {
                SignUpView(showLogin: { shouldShowSignUp = false } ).navigationBarBackButtonHidden(true)
            }
        }
    }
}

extension LoginView {
    func login() async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
            )
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
