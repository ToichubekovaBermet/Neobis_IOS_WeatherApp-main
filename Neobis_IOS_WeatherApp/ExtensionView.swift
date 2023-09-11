import UIKit

extension ViewController: UISearchBarDelegate {
    @objc func buttonTapped() {
       
        
        searchLocation.isHidden = !searchLocation.isHidden
       }
}
