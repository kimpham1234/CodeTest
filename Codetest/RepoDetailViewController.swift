//
//  RepoDetailViewController.swift
//  Codetest
//
//  Created by Kim Pham on 9/30/17.
//  Copyright © 2017 BooBoo. All rights reserved.
//

import UIKit
import Octokit

class RepoDetailViewController: UIViewController {
    
    var repoName = ""
    var owner = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Octokit().repository(owner: owner, name: repoName){ response in
            switch response{
                case .success(let reposistory):
                    print(reposistory.gitURL)
                case .failure(let error):
                    print(error)
            }
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
