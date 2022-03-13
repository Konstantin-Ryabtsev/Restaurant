//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import UIKit

class OrderTableViewController: UITableViewController {
    // MARK: - Constants
    let cellManager = CellManager()
    let networkManager = NetworkManager()
    
    // MARK: - IBOutlets
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    // MARK: - Stored Properties
    private var minutes = 0
    
    // MARK: - UITableViewController Mehods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: OrderManager.orderUpdatedNotification, object: nil)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "OrderConfirmationSegue" else { return }
        let destination = segue.destination as! OrderConfirmationViewController
        destination.minutes = minutes
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        OrderManager.shared.order = Order()
        updateUI()
    }
    
    // MARK: - Custom Methods
    func updateUI() {
        submitButton.isEnabled = OrderManager.shared.order.orderItems.count > 0
    }
    
    func uploadOrder() {
        var orderIds: [Int] = []
        for orderItem in OrderManager.shared.order.orderItems {
            for _ in 1 ... orderItem.count {
                orderIds.append(orderItem.id)
            }
        }
        
        networkManager.submitOrder(forMenuIds: orderIds) { minutes, error in
            if let error = error {
                print(#line, #function, "ERROR: \(error.localizedDescription)")
            } else {
                guard let minutes = minutes else {
                    print(#line, #function, "ERROR: didn't get minutes from the server")
                    return
                }
                self.minutes = minutes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "OrderConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        let orderTotal = OrderManager.shared.order.orderItems.reduce(0) { $0 + Double($1.count) * $1.price }
        
        let alert = UIAlertController(
            title: "Confirm Order",
            message: "Your are about to submit your order with a total of \(orderTotal.formattedHundreds)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
            self.uploadOrder()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension OrderTableViewController /*: UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.shared.order.orderItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        let orderItem = OrderManager.shared.order.orderItems[indexPath.row]
        cellManager.configure(cell, with: orderItem, for: tableView, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            tableView.beginUpdates()
            let orderCount = OrderManager.shared.order.orderItems.count
            OrderManager.removeItem(at: indexPath.row)
            if orderCount != OrderManager.shared.order.orderItems.count {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
            updateUI()
        case .none:
            break
        case .insert:
            break
        @unknown default:
            print(#line, #function, "Unknown case in file \(#file)")
            break
        }
    }
}

// MARK: - UITableViewDelegate
extension OrderTableViewController /*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
