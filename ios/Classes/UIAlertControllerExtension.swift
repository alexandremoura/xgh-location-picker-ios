import UIKit

extension UIAlertController {
    func addCustomLocationPicker(location: Location? = nil, completion: @escaping LocationPickerViewController.CompletionHandler) {
        let vc = LocationPickerViewController()

        vc.view.frame = self.view.frame

        vc.searchController.searchBar.backgroundColor = UIColor(white: 0, alpha: 0.6)
        vc.searchController.searchBar.layer.cornerRadius = 10

        if let textFieldInsideSearchBar = vc.searchController.searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {

                //Magnifying glass
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = .white
        }

        vc.location = location
        vc.completion = completion
        set(vc: vc)
    }
}