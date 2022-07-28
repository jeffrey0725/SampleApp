//
//  InfoTableViewController.swift
//  SampleApp
//
//  Created by Jeffrey Cheung on 23/6/2022.
//

import UIKit

class InfoTableViewController: UITableViewController {
    let child = SpinnerViewController()
    let apiManager = APIManager.getInstance()
    var pageCount = 1
    var characterModel: CharacterModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Characters"
        registerTableViewCell()
        callInitApi {
            self.stopLoading()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Loading
    func startLoading() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func stopLoading() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    //MARK: - API
    func callInitApi(_ success: @escaping () -> ()) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getCharacters({ (response) in
            self.characterModel = response
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main, execute: {
            success()
        })
    }
    
    func getCharacters(_ success: @escaping (CharacterModel?) -> ()) {
        let urlString = APIEndpoint().baseEndpoint + APIPath().getCharacter + "?page=\(pageCount)"
        if let url = URL(string: urlString) {
            apiManager.getCharacters(url: url, success: { (response) in
                success(response)
            })
        }
    }
    
    //MARK: - Register table view cell
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return 0
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return 0
        return characterModel?.characters?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let data = characterModel?.characters?[indexPath.row]
        cell.lblTitle.text = data?.name ?? ""
        if indexPath.row == (characterModel?.characters?.count ?? 0) - 1 {
            pageCount += 1
            if characterModel?.nextPage?.count ?? 0 > 0 {
                getCharacters({ (response) in
                    if let data = response {
                        for character in data.characters ?? [] {
                            self.characterModel?.characters?.append(character)
                        }
                        self.characterModel?.nextPage = data.nextPage ?? ""
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Info", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController {
            let data = characterModel?.characters?[indexPath.row]
            vc.characterDetail = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
