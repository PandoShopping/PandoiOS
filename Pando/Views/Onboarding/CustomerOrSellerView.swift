//
//  CustomerOrSellerView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/4/23.
//

import SwiftUI

struct CustomerOrSellerView: View {
    var body: some View {
        VStack {
            Text("Which statement describes you?")
            Button {
                //action
            } label: {
                Text("I'm a customer")
            }
            Button {
                //action
            } label: {
                Text("I'm a seller")
            }
        }
    }
}

struct CustomerOrSellerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerOrSellerView()
    }
}
