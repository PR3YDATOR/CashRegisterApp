//
//  ViewController.swift
//  CashRegisterApp
//
//  Created by user238852 on 2/26/24.
//
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var selectedProductLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    
    
    var valueString : String = ""
    var selectedRow : Int?
    
    var productManager : ProductManager = ProductManager()
    var historyManager : HistoryManager = HistoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedProductLabel.text = ""
        resetFields()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let managerVC = segue.destination as? ManagerViewController
        managerVC!.productManager = productManager
        managerVC!.historyManager = historyManager
    }
    
    func resetFields() {
        quantityLabel.isHidden = true;
        quantityLabel.text = ""
        valueString = ""
        totalAmountLabel.isHidden = true
        totalAmountLabel.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productManager.fetchProducts().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customerTableViewCell
        
        cell.productName?.text = productManager.fetchProducts()[indexPath.row].name
        
        let qty = productManager.fetchProducts()[indexPath.row].quantity ?? 0;
        cell.productQty?.text = "\(qty)"
        
        let price = productManager.fetchProducts()[indexPath.row].cost ?? 0;
        cell.productPrice?.text = "\(price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resetFields()
        selectedProductLabel.isHidden = false
        selectedProductLabel.text = productManager.fetchProducts()[indexPath.row].name
        selectedRow = indexPath.row
        
    }

    @IBAction func qtySelected(_ sender: Any) {
        if let btnTitle = (sender as! UIButton).currentTitle {
            guard let selectedRow = selectedRow else {
                // No cell selected, show alert
                showAlert(message: "Select a product first")
                return
            }
            
            if let btnTitle = (sender as! UIButton).currentTitle {
                valueString.append(btnTitle)
            }
            
            quantityLabel.isHidden = false
            quantityLabel.text = valueString
            
            let cost = productManager.fetchProducts()[selectedRow].cost * Double(valueString)!;
            totalAmountLabel.isHidden = false
            totalAmountLabel.text = "\(cost)"
            
            if let number = Int(valueString) {
                if number > productManager.fetchProducts()[selectedRow].quantity {
                    showAlert(message: "Selected quantity cannot be greater than the stock quantity.")
                }
            }
        }
    }
    
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error!!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { action in
                self.resetFields()
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    @IBAction func buyProduct(_ sender: Any) {
        if (selectedRow != nil) { 
                        productManager.fetchProducts()[selectedRow!].quantity -= Int(valueString)!
                        historyManager.addPurchaseHistory(product: productManager.fetchProducts()[selectedRow!], newQty:Int(valueString)!)
                        productTableView.reloadData()
        }
    }
    
   

}

