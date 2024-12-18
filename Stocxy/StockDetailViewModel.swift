//
//  StockDetailViewModel.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//

import Foundation
import Combine

class StockDetailViewModel: ObservableObject {
    @Published var stock: Stock? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let symbol: String
    private let stockService: StockService
    private var cancellables = Set<AnyCancellable>()
    
    init(symbol: String, stockService: StockService = StockService(apiKey: "KA4RSWXB3C7JMQ5OCK6ED")) {
        self.symbol = symbol
        self.stockService = stockService
    }
    
    func fetchStockDetails() {
        isLoading = true
        errorMessage = nil
        
        stockService.fetchStockQuote(symbol: symbol)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] stock in
                self?.stock = stock
            }
            .store(in: &cancellables)
    }
}
