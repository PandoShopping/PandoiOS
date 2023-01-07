//
//  ConfirmSignUpView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI
import Amplify

struct ConfirmSignUpView: View {

    @State private var confirmationCode: String = ""
    @State private var shouldShowLogin: Bool = false

    let username: String

    var body: some View {
        VStack {
            Text("Enter your VerificationCode")
            TextField("Vertification Code", text: $confirmationCode)
            Button {
                Task { await confirmSignUp() }
            } label: {
                Text("Submit")
            }
        }
        .navigationDestination(isPresented: .constant(shouldShowLogin)) {
            LoginView() //TODO: user has to login after signing up --> eliminate and have automatic sign up 
        }
    }
}


extension ConfirmSignUpView {
    func confirmSignUp() async {
        do {
            let result = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
            switch result.nextStep {
            case .done:
                DispatchQueue.main.async {
                    self.shouldShowLogin = true 
                }
            default:
                print (result.nextStep)
            }

        } catch let error as AuthError {
            print("an error occured while confirming signup \(error)")
        }
        catch {
            print (error)
        }
    }
}


struct ConfirmSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSignUpView(username: "testUsername")
    }
}
