//
//  SignUpView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI
import Amplify

struct SignUpView: View {

    let showLogin: () -> Void

    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State var shouldShowConfirmSignUp: Bool = false

    var body: some View {
        VStack {
            Text("Welcome to Pando!")
            TextField("Enter your username", text: $username)
            TextField("Enter your email", text: $email)
            SecureField("Enter your password", text: $password)
            Button {
                Task { await signUp() }
            } label: {
                Text("Continue")
            }
            Text("or sign up with")
            Button {
                //action
            } label: {
                Text("Sign up with Google")
            }
            Button {
                //action
            } label: {
                Text("Sign up with Apple")
            }
            Button {
                //action
            } label: {
                Text("Already have an account? Login.")
            }
        }
        .navigationDestination(isPresented: .constant(shouldShowConfirmSignUp)) {
            ConfirmSignUpView(username: username)
        }
    }
}




extension SignUpView {
    @ViewBuilder func squareOrCircle() -> some View {
        if (2/2 == 1) {
            Circle()
        } else {
            Rectangle()
        }
    }
}


extension SignUpView {
    func signUp() async {
        let options = AuthSignUpRequest.Options(userAttributes: [.init(.email, value: email), .init(.name, value: "Asritha")])
        do {
            let result = try await Amplify.Auth.signUp(username: username, password: password, options: options)
            if case let .confirmUser(deliveryDetails, _, userId) = result.nextStep {
                DispatchQueue.main.async {
                    shouldShowConfirmSignUp = true
                }
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showLogin: { })
    }
}
