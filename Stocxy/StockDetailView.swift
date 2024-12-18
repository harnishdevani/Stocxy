//
//  StockDetailView.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//

import SwiftUI

struct StockDetailView: View {
    let stockSymbol: String
    @StateObject private var viewModel: StockDetailViewModel
    
    init(stockSymbol: String) {
        self.stockSymbol = stockSymbol
        _viewModel = StateObject(wrappedValue: StockDetailViewModel(symbol: stockSymbol))
    }
    
    var body: some View {
        VStack {
            if let stock = viewModel.stock {
                VStack(alignment: .leading, spacing: 10) {
                    Text(stock.symbol)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Current Price:")
                        Spacer()
                        Text("$\(stock.price, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        Text("Change:")
                        Spacer()
                        Text(stock.change)
                            .foregroundColor(stock.changeColor)
                    }
                    
                    HStack {
                        Text("Change Percent:")
                        Spacer()
                        Text(stock.changePercent)
                            .foregroundColor(stock.changeColor)
                    }
                }
                .padding()
            } else if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Stock Details")
        .onAppear {
            viewModel.fetchStockDetails()
        }
    }
}
