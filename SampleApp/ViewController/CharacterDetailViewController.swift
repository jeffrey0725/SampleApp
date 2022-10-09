//
//  CharacterDetailViewController.swift
//  SampleApp
//
//  Created by Jeffrey Cheung on 24/6/2022.
//

import UIKit

class CharacterDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var characterDetail: Characters?
    
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = characterDetail?.name ?? ""
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupLayout() {
        // Setup image
        if let imgURL = URL(string: characterDetail?.imageUrl ?? "") {
            let imgData = try? Data(contentsOf: imgURL)
            ivIcon.image = UIImage(data: imgData!)
        }
        
        // Setup title
        lblName.text = characterDetail?.name ?? ""
        lblName.textAlignment = .center
        
        // Setup
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
