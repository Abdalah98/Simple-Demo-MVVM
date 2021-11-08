//
//  ViewController.swift
//  MVVM Demo
//
//  Created by Abdallah on 11/7/21.
//

import UIKit
import SDWebImage
import SafariServices
class TopFreeAppVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel : TopFreeAppViewModel = TopFreeAppViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension TopFreeAppVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountapp()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TopFreeAppCell
        cell.name.text = viewModel.getArtistName(at: indexPath)
        cell.kind.text = viewModel.getName(at: indexPath)
        cell.imageUrl.sd_setImage(with:URL(string:viewModel.getImage(at: indexPath)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goSafari(urlString: viewModel.openUrl(at: indexPath) )
    }
    
    
    func goSafari(urlString: String){
    guard let url = URL(string:urlString ) else {return}
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = .systemRed
    self.present(safariVC, animated: true)
    }
}
