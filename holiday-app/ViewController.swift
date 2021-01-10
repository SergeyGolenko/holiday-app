//
//  ViewController.swift
//  holiday-app
//
//  Created by Сергей Голенко on 09.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - IBOutlets and IBAction
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBAction func getStartedButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Navigation controller methods
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated:animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated:animated)
    }
    
    //MARK: - functions
    private func setupViews(){
        getStartedButton.layer.cornerRadius = 28
        getStartedButton.layer.masksToBounds = true
        
    }

}

