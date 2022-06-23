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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCharacters({ (response) in
            self.characterModel = response
            print("success")
        })
    }
    
    func getCharacters(_ success: @escaping (CharacterModel?) -> ()) {
        let urlString = APIEndpoint().baseEndpoint + APIPath().getCharacter + "?page=\(pageCount)"
        if let url = URL(string: urlString) {
            print(url)
            apiManager.getCharacters(url: url, success: { (response) in
                success(response)
            })
        }
    }
}

