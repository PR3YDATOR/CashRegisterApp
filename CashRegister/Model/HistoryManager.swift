

import Foundation

class HistoryManager {
    
    var historyProducts = [History]()
    
    func addPurchaseHistory(product : Product, newQty:Int) {
        var histProduct = History(histName:product.name, histQty:newQty, histCost:(product.cost * Double(newQty)))
        historyProducts.append(histProduct)
    }
    
    func fetchPurchaseHistory() -> [History]{
        return historyProducts
    }
}
