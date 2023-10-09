//
//  ViewController.swift
//  Networking
//
//  Created by Jonathan Casillas on 03/10/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var downloadImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        emailLabel.text = ""
        emailLabel.numberOfLines = 0
        idLabel.text = ""
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
    }

    @IBAction func getUserAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        
        NetworkingProvider.shared.getUserV2(id: 5313648) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            self.idLabel.text = user.id?.description
            
            print("success --> ", user)
            
        } failure: { (error) in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = error.debugDescription
        }

    }
    
    @IBAction func addUserAction(_ sender: Any) {
        
        let newUser = NewUser(name: "Jonathan", email: "JonCasDevTest@test.com", gender: "Male", status: "active")
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.addUser(user: newUser ) { user in
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
            
        } failure: { error in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = error.debugDescription
        }
        
    }
    
    @IBAction func updateUserAction(_ sender: Any) {
        let newUser = NewUser(name: "Capter", email: nil, gender: nil, status: nil)
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.updateUser(id: 5315410 , user: newUser ) { user in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)

            
        } failure: { error in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = error.debugDescription
        }
        
    }
    
    @IBAction func deleteUserAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        let id = 5315410
        
        NetworkingProvider.shared.deleteUser(id: id) {
            
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = "Se han borrado el ususario con ID: \(id)"
            self.emailLabel.text = ""
            self.idLabel.text = ""
            
        } failure: { error in
            
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = error.debugDescription
        }

    }
    
    @IBAction func downloadImageAction(_ sender: Any) {
        downloadImageButton.isHidden = true
        logoImageView.kf.setImage(with: URL(string: "https://www.apple.com/v/swift/c/images/overview/icon_swift_hero_large.png"))
        
    }
    
    
    private func setup( user: User ){
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
        self.idLabel.text = user.id?.description
    }
    
    
}

