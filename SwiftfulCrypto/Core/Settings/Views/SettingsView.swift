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
        }
        .navigationViewStyle(.stack)
    }
}

extension SettingsView {
    
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
            
            if #available(iOS 14.0, *) {
                Link("Source Code on Github 🥳", destination: githubURL)
                Link("Buy me a coffee ☕️", destination: coffeeURL)
            } else {
                Button(action: {
                    UIApplication.shared.open(githubURL)
                }) {
                    Text("Source Code on Github 🥳")
                }
                Button(action: {
                    UIApplication.shared.open(coffeeURL)
                }) {
                    Text("Buy me a coffee ☕️")
                }
            }
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
            
            if #available(iOS 14.0, *) {
                Link("Watch the course on Youtube 📺", destination: youtubeURL)
            } else {
                Button(action: {
                    UIApplication.shared.open(githubURL)
                }) {
                    Text("Watch the course on Youtube 🥳")
                }
            }
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
            
            if #available(iOS 14.0, *) {
                Link("Visit CoinGecko 🦎", destination: coinGeckoURL)
            } else {
                Button(action: {
                    UIApplication.shared.open(coinGeckoURL)
                }) {
                    Text("Visit CoinGecko 🦎")
                }
            }
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application".uppercased())) {
            if #available(iOS 14.0, *) {
                Link("Terms of Service", destination: defaultURL)
                Link("Privacy Policy", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn More", destination: defaultURL)
            } else {
                Button(action: {
                    UIApplication.shared.open(defaultURL)
                }) {
                    Text("Terms of Service")
                }
                Button(action: {
                    UIApplication.shared.open(defaultURL)
                }) {
                    Text("Privacy Policy")
                }
                Button(action: {
                    UIApplication.shared.open(defaultURL)
                }) {
                    Text("Company Website")
                }
                Button(action: {
                    UIApplication.shared.open(defaultURL)
                }) {
                    Text("Learn More")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
