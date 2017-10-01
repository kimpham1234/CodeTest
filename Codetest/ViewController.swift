//
//  ViewController.swift
//  Codetest
//
//  Created by Kim Pham on 9/30/17.
//  Copyright © 2017 BooBoo. All rights reserved.
//

import UIKit
import Octokit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var repotable: UITableView!
    var username = ""
    var reponames = [String]()
    var repoName = ""
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    @IBAction func getInfoButton(_ sender: UIButton) {
        username = usernameTextField.text!
        Octokit().repositories(owner: username){response in
            switch response {
            case .success(let repositories):
                for repo in repositories{
                    self.reponames.append(repo.name!)
                }
                print(self.reponames[0])
                DispatchQueue.main.async {
                    self.repotable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        
        }
        
    }
    
    @IBOutlet weak var infoTextView: UITextView!
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reponames.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = reponames[indexPath.row]
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repoName = reponames[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let detailViewController = segue.destination as! RepoDetailViewController
            detailViewController.repoName = repoName
            detailViewController.owner = username
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func updateUI(info: String){
        infoTextView.text = info
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        return true
    }

}

