//
//  CellManager.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 01.03.2022.
//

import UIKit

class CellManager {
    let networkManager = NetworkManager()
    
    func configure(_ cell: UITableViewCell, with category: String) {
        var content = cell.defaultContentConfiguration()
        content.text = category.localizedCapitalized
        cell.contentConfiguration = content
    }
    
    func configure(_ cell: UITableViewCell, with menuItem: MenuItem, for tableView: UITableView, indexPath: IndexPath) {
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        
        guard cell.imageView?.image == nil else { return }
        networkManager.getImage(menuItem.imageURL) { image, error in
            if let error = error {
                print(#line, #function, "ERROR:", error.localizedDescription)
            }
            DispatchQueue.main.async {
                cell.imageView?.image = image
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        /*
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = String(format: "$%.2f", menuItem.price)
        
        networkManager.getImage(menuItem.imageURL) { image, error in
            if let error = error {
                print(#line, #function, "ERROR:", error.localizedDescription)
            }
            DispatchQueue.main.async {
                content.image = image
                tableView?.reloadData()
            }
        }
        
        cell.contentConfiguration = content
        */
    }
}
