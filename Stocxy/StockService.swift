//
//  StockService.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//
import Foundation
import Combine

class StockService {
    private let apiKey: String
    private var cancellables = Set<AnyCancellable>()
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchStockQuote(symbol: String) -> AnyPublisher<Stock, Error> {
        guard let url = URL(string: "https://www.alphavantage.co/query") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: GlobalQuoteResponse.self, decoder: JSONDecoder())
            .map { response -> Stock in
                Stock(
                    symbol: response.globalQuote.symbol,
                    price: Double(response.globalQuote.price) ?? 0.0,
                    change: response.globalQuote.change,
                    changePercent: response.globalQuote.changePercent
                )
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
