//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let githubURL = URL(string: "https://github.com/tonyh2021/SwiftfulCrypto")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/tongh2021")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu")!
    let defaultURL = URL(string: "https://www.google.com")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.expandViewOutOfSafeArea()
                listViewBuilder
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension SettingsView {
    
    @ViewBuilder private var listViewBuilder: some View {
        if #available(iOS 14.0, *) {
            listView
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xButton
                }
            }
        } else {
            listView
            .navigationBarTitle(
                Text("Settings"),
                displayMode: .large)
            .navigationBarItems(trailing: xButton)
        }
    }
    
    private var xButton: some View {
        XMarkButton {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var listView: some View {
        List {
            developerView
                .listRowBackground(Color.theme.background.opacity(0.5))
            swiftfulThinkingSection
                .listRowBackground(Color.theme.background.opacity(0.5))
            coinGeckoSection
                .listRowBackground(Color.theme.background.opacity(0.5))
            applicationSection
                .listRowBackground(Color.theme.background.opacity(0.5))
        }
        .listStyle(PlainListStyle())
        .font(.headline)
        .accentColor(.blue)
    }
    
    private var developerView: some View {
        Section(header: Text("Tonyh2021".uppercased())) {
            VStack(alignment: .leading) {
                Image("tonyh2021")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                Text("This app is developed by Tony. It uses SwiftUI, MVVM architecture, Combine and CoreData. I also improve it by supporting iOS 13!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.top)
            
            LinkAdaptor("Source Code on Github 🥳", destination: githubURL)
            LinkAdaptor("Buy me a coffee ☕️", destination: coffeeURL)
        }
    }
    
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Swiftful Thinking".uppercased())) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                Text("This project was made by following a @SwiftfulThinking course on Youtube. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.top)
            
            LinkAdaptor("Watch the course on Youtube 📺", destination: youtubeURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko".uppercased())) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 90)
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Data may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.top)
            
            LinkAdaptor("Visit CoinGecko 🦎", destination: coinGeckoURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application".uppercased())) {
            
            LinkAdaptor("Terms of Service", destination: defaultURL)
            LinkAdaptor("Privacy Policy", destination: defaultURL)
            LinkAdaptor("Company Website", destination: defaultURL)
            LinkAdaptor("Learn More", destination: defaultURL)
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
