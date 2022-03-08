//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Konstantin Ryabtsev on 08.03.2022.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your waiting time is approximately \(minutes!) minutes."
    }

}
