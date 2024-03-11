

import Foundation

class ProductManager {

    var products = [
        Product(pName: "Pants", pQty: 50, pCost:  35),
        Product(pName: "Shoes", pQty: 150, pCost:  80),
        Product(pName: "Hats", pQty: 15, pCost:  20),
        Product(pName: "Tshirts", pQty: 75, pCost:  30),
        Product(pName: "Dresses", pQty: 60, pCost:  60),
    ]
    
    func fetchProducts() -> [Product] {
        return products
    }
}
