//
//  DataView.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import SwiftUI

struct DataView: View {
    var viewModel = DataViewModel()
    var body: some View {
        
        HStack{
            VStack(alignment: .trailing) {
                Text("Air Quality")
                    .bold()
                    .font(.title)
                Text("Air Pollutions").font(.title)
                
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("SO").font(.title)
                    Text("2").font(.subheadline)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("NO").font(.title)
                    Text("2").font(.subheadline)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("PM").font(.title)
                    Text("10").font(.subheadline)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("PM").font(.title)
                    Text("2.5").font(.subheadline)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("O").font(.title)
                    Text("3").font(.subheadline)
                }
                Text("CO").font(.title)
            }
            .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(viewModel.airQuality.airQuality.rawValue)
                    .bold()
                    .font(.title)
                Text("μg/m3").font(.title)
                Text(String(viewModel.airQuality.so2)).font(.title)
                Text(String(viewModel.airQuality.no2)).font(.title)
                Text(String(viewModel.airQuality.pm10)).font(.title)
                Text(String(viewModel.airQuality.pm25)).font(.title)
                Text(String(viewModel.airQuality.o3)).font(.title)
                Text(String(viewModel.airQuality.co)).font(.title)
            }
        }
    }
}

#Preview {
    DataView()
}
