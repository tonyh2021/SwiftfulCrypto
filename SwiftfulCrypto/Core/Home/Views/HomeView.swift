//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioSheet: Bool = false
    
    var body: some View {
        // debug printing
//        let _ = print(showPortfolio)
        ZStack {
            Color.theme.background.expandViewOutOfSafeArea()
                .sheet(isPresented: $showPortfolioSheet) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            VStack {
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsListView
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsListView
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
            // https://stackoverflow.com/questions/69443588/how-to-replace-deprecated-animation-in-swiftui
                .animation(nil, value: UUID())
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioSheet.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(nil, value: UUID())
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsListView: some View {
        GeometryReader { geometry in
            RefreshScrollView(width: geometry.size.width, height: geometry.size.height, vm: vm)
        }
    }
    
    private var portfolioCoinsListView: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price").frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
//            Button {
//                withAnimation(.linear(duration: 2.0)) {
//                    vm.reloadData()
//                }
//            } label: {
//                Image(systemName: "goforward")
//            }
//            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondary)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}
