//
//  MapView.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 11/11/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Map(coordinateRegion: $region).frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MapView()
}
