//
//  ItemViewController.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import UIKit

class ItemViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    // MARK: - Stored Properties
    var menuItem: MenuItem!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addToOrderButton.layer.cornerRadius = 5
        updateUI()
    }
    
    // MARK: - UI Methods
    func updateUI() {
        navigationItem.title = menuItem.name
        imageView.image = menuItem.image
        priceLabel.text = menuItem.formattedPrice
        detailTextLabel.text = menuItem.detailText
    }

    // MARK: - Actions
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.addToOrderButton.transform = CGAffineTransform.identity
        }
        OrderManager.shared.order.menuItems.append(menuItem)
    }
    
}
