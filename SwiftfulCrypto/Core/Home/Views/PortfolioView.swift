//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-22.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                scrollView.toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        xView
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        saveView
                    }
                }
            } else {
                scrollView.navigationBarItems(
                    leading:xView,
                    trailing: saveView
                )
            }
        }
        .valueChanged(value: vm.searchText, onChange: { newValue in
            if newValue == "" {
                removeSelectedCoin()
            }
        })
    }
}

extension PortfolioView {
    private var scrollView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBarView(searchText: $vm.searchText)
                coinListView
                
                if selectedCoin != nil {
                    portfolioInputSection
                }
            }
        }
        .navigationBarTitle("Edit Portfolio")
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }), let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
    
    private var coinListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if #available(iOS 14.0, *) {
                LazyHStack(spacing: 10) {
                    forEachView
                }
                .padding(.leading)
            } else {
                HStack(spacing: 10) {
                    forEachView
                }
                .padding(.leading)
            }
        }
        .frame(height: 120)
    }
    
    private var forEachView: some View {
        ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCions) { coin in
            CoinLogoView(coin: coin)
                .frame(width: 75)
                .padding(4)
                .onTapGesture {
                    withAnimation(.easeIn) {
                        updateSelectedCoin(coin: coin)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedCoin?.id == coin.id ?  Color.theme.green : Color.clear, lineWidth: 1)
                )
        }
    }
    
    private var xView: some View {
        XMarkButton {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var saveView: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPress()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func saveButtonPress() {
        guard let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
