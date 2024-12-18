//
//  ContentView.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TickerView()
                .tabItem {
                    Label("Ticker", systemImage: "chart.bar.xaxis")
                }

            Text("News (Coming Soon)")
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

