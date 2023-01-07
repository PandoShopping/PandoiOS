//
//  SignUpOrLoginView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI

struct SignUpOrLoginView: View {
    var body: some View {
        VStack {
            Text("Pando")
            Text("Buy and sell locally")
            Button {
                //action
            } label: {
                Text("Sign Up")
            }
            Button {
                //action
            } label: {
                Text("Login")
            }

        }
    }
}

struct SignUpOrLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpOrLoginView()
    }
}
