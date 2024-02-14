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
            Image("background 1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 3.0)
            AirQualityView(viewModel: viewModel)
                .padding(.bottom)
        }
        .onAppear(perform: {
            viewModel.getLocation()
        })
        .alert(isPresented: $viewModel.shouldShowAlert, content: {
            Alert(title: Text("Please Grant Location Permission"), message: Text("This app needs your location to display airquality around you"), dismissButton: .default(Text("Got it!")))
        })
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
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                Text("Air Pollutions")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("SO")
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("2")
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("NO")
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("2")
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("PM")
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("10")
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("PM")
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("2.5")
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                HStack(alignment: .firstTextBaseline, spacing: .zero){
                    Text("O")
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("3")
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                Text("CO")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
            }
            .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(viewModel.pollutionData?.airQuality.airQuality.rawValue ?? "unkown")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Text("μg/m3")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.so2 ?? 0.0))
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.no2 ?? 0.0))
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.pm10 ?? 0.0))
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.pm25 ?? 0.0))
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.o3 ?? 0.0))
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text(String(viewModel.pollutionData?.airQuality.co ?? 0.0))
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
    }
}
#Preview {
    PollutionDataView()
}
