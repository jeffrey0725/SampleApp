//
//  ViewController.swift
//  SampleApp
//
//  Created by Jeffrey Cheung on 21/6/2022.
//

import UIKit

class ViewController: UIViewController {
    private let apiManager = APIManager.getInstance()
    var pageCount = 1
    var characterModel: CharacterModel?
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnNext: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initUI() {
        lblText.numberOfLines = 0
        lblText.text = "Welcome"
        btnNext.setTitle("Get start", for: .normal)
    }
    
    @IBAction func nextPress(_ sender: Any) {
        print("Pressed")
        if let vc = UIStoryboard.init(name: "Info", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfoTableViewController") as? InfoTableViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

