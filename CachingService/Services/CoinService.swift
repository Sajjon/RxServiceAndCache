//
//  CoinService.swift
//  CachingService
//
//  Created by Alexander Cyon on 2017-12-02.
//  Copyright © 2017 Alexander Cyon. All rights reserved.
//

import Foundation
import RxSwift

protocol CoinServiceProtocol: Service, Persisting {
    func getCoins(fromSource source: ServiceSource) -> Observable<[Coin]>
    func getCachedCoins(using filter: FilterConvertible) -> Observable<[Coin]>
}

final class CoinService: CoinServiceProtocol {
    typealias Router = CoinRouter
    
    let httpClient: HTTPClientProtocol
    let cache: AsyncCache
    
    init(
        httpClient: HTTPClientProtocol,
        cache: AsyncCache) {
        self.httpClient = httpClient
        self.cache = cache
    }
    
    func getCoins(fromSource source: ServiceSource = .default) -> Observable<[Coin]> {
        return get(modelType: CoinsResponse.self, request: CoinRouter.all, from: source).map { $0.coins }
    }
    
    func getCachedCoins(using filter: FilterConvertible) -> Observable<[Coin]> {
        return getModels(using: filter)
    }
}
