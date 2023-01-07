//
//  LocationPermissionsDeniedView.swift
//  Pando
//
//  Created by Asritha Bodepudi on 1/6/23.
//

import SwiftUI

struct LocationPermissionsDeniedView: View {
    var body: some View {
        Text("You have denied location permissions. please go into settings and enable them to continue using the app")
    }
}

struct LocationPermissionsDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionsDeniedView()
    }
}
