//
//  TickerView.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//

import SwiftUI
import Combine

struct TickerView: View {
    @StateObject private var viewModel = TickerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter company symbol", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.allCharacters)

                    Button(action: viewModel.searchStockData) {
                        Text("Search")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.stocks) { stock in
                        NavigationLink(destination: StockDetailView(stockSymbol: stock.symbol)) {
                            HStack {
                                Text(stock.symbol)
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("\(stock.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                    Text(stock.changePercent)
                                        .font(.subheadline)
                                        .foregroundColor(stock.changeColor)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Stock Ticker")
        }
    }
}

#Preview {
    TickerView()
}
