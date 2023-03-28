//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-23.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @ObservedObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private var spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        self.vm = DetailViewModel(coin: coin)
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.expandViewOutOfSafeArea()
            
            if #available(iOS 14.0, *) {
                scrollView
                    .background(
                        Color.theme.background
                    )
                    .navigationTitle(vm.coin.name)
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            navigationBarTrailingItem
                    }
                }
            } else {
                scrollView
                    .navigationBarTitle(
                        Text(vm.coin.name),
                        displayMode: .large)
                    .navigationBarItems(
                        trailing: navigationBarTrailingItem
                )
            }
        }
    }
}

extension DetailView {
    
    private var scrollView: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
    }
    
    private var navigationBarTrailingItem: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondary)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder private var descriptionSection: some View {
        if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
            VStack(alignment: .leading) {
                Text(coinDescription)
                    .lineLimit(showFullDescription ? nil : 3)
                    .font(.callout)
                    .foregroundColor(Color.theme.secondary)
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                } label: {
                    Text(showFullDescription ? "Less" : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }
                .accentColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder private var overviewGrid: some View {
        if #available(iOS 14.0, *) {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                alignment: .leading,
                spacing: spacing,
                pinnedViews: []
            ) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
        } else {
            // Fallback on earlier versions
            let col = 2
            let row = vm.overviewStatistics.count / col
            VStack(spacing: spacing) {
                ForEach(0..<row, id: \.self) { rowIndex in
                    HStack() {
                        ForEach(0..<col, id: \.self) { colIndex in
                            ZStack(alignment: .leading) {
                                Color.theme.background
                                StatisticView(stat: vm.overviewStatistics[rowIndex * col + colIndex])
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder private var additionalGrid: some View {
        if #available(iOS 14.0, *) {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                alignment: .leading,
                spacing: spacing,
                pinnedViews: []
            ) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
        } else {
            // Fallback on earlier versions
            VStack(spacing: spacing) {
                let col = 2
                let row = vm.additionalStatistics.count / col
                ForEach(0..<row, id: \.self) { rowIndex in
                    HStack() {
                        ForEach(0..<col, id: \.self) { colIndex in
                            ZStack(alignment: .leading) {
                                Color.theme.background
                                StatisticView(stat: vm.additionalStatistics[rowIndex * col + colIndex])
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                if #available(iOS 14.0, *) {
                    Link("Website", destination: url)
                } else {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Text("Website")
                    }
                }
            }
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                if #available(iOS 14.0, *) {
                    Link("Reddit", destination: url)
                } else {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Text("Reddit")
                    }
                }
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
