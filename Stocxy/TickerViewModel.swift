//
//  TickerViewModel.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//

import Foundation
import Combine

class TickerViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var searchQuery: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let stockService: StockService
    private var cancellables = Set<AnyCancellable>()
    
    init(stockService: StockService = StockService(apiKey: "VAYMJA49RT0G1RW3")) {
        self.stockService = stockService
        setupSearchPublisher()
    }
    
    private func setupSearchPublisher() {
        // Optional: Add debounce to reduce API calls
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] symbol in
                self?.searchStockData()
            }
            .store(in: &cancellables)
    }
    
    func searchStockData() {
        guard !searchQuery.isEmpty else {
            errorMessage = "Please enter a valid symbol"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        stockService.fetchStockQuote(symbol: searchQuery)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] stock in
                self?.stocks = [stock]
            }
            .store(in: &cancellables)
    }
}
