//
//  DataView.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import SwiftUI

struct PollutionDataView: View {
    @ObservedObject var viewModel = PollutionDataViewModel(pollutionData: nil)
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "location.circle").imageScale(.large).padding()
                }
            }
            AirQualityView(viewModel: viewModel)
        }
    }
}

struct AirQualityView: View {
    @ObservedObject var viewModel: PollutionDataViewModel
    
    init(viewModel: PollutionDataViewModel = PollutionDataViewModel(pollutionData: nil)) {
        self.viewModel = viewModel
    }
    
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
                Text(viewModel.pollutionData?.airQuality.airQuality.rawValue ?? "unkown")
                    .bold()
                    .font(.title)
                Text("μg/m3").font(.title)
                Text(String(viewModel.pollutionData?.airQuality.so2 ?? 0.0)).font(.title)
                Text(String(viewModel.pollutionData?.airQuality.no2 ?? 0.0)).font(.title)
                Text(String(viewModel.pollutionData?.airQuality.pm10 ?? 0.0)).font(.title)
                Text(String(viewModel.pollutionData?.airQuality.pm25 ?? 0.0)).font(.title)
                Text(String(viewModel.pollutionData?.airQuality.o3 ?? 0.0)).font(.title)
                Text(String(viewModel.pollutionData?.airQuality.co ?? 0.0)).font(.title)
            }
        }.onAppear{
            viewModel.fetchData()
        }
    }
}
#Preview {
    PollutionDataView()
}
