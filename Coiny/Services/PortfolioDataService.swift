//
//  PortfolioDataService.swift
//  Coiny
//
//  Created by Mohamed Atallah on 04/08/2025.
//

import Foundation
import CoreData

final class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                Logger.shared.log("Error loading persistent store: \(error)", level: .error)
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - PUBLIC
    
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            Logger.shared.log("Error fetching Portfolio entities: \(error)", level: .error)
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            Logger.shared.log("Error saving to core Data: \(error)", level: .error)
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
