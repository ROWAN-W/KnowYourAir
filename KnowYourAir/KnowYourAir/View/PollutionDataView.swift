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
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Button {
                        viewModel.refreshLocation()
                    } label: {
                        Image(systemName: "location.circle").imageScale(.large).padding()
                    }
                }
                AirQualityView(viewModel: viewModel)
            }
            
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
                    .foregroundStyle(.white)
                
                Text("Air Pollutions")
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("SO")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("2")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("NO")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("2")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("PM")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("10")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("PM")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("2.5")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("O")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("3")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                Text("CO")
                    .font(.title)
                    .foregroundStyle(.white)
            }
            .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(viewModel.pollutionData?.airQuality.airQuality.rawValue ?? "unkown")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text("μg/m3")
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.so2 ?? 0.0))
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.no2 ?? 0.0))
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.pm10 ?? 0.0))
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.pm25 ?? 0.0))
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.o3 ?? 0.0))
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.co ?? 0.0))
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }.onAppear{
            viewModel.fetchData()
        }
    }
}
#Preview {
    PollutionDataView()
}
