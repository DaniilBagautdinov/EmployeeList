import UIKit

class CustomButton: UIButton {
    public func configureButton() -> UIButton {
        layer.cornerRadius = 30
        backgroundColor = #colorLiteral(red: 0.4272407889, green: 0.7135782838, blue: 0.9854105115, alpha: 1)
        setTitleColor(.white, for: .normal)
        setTitle("Retry", for: .normal)
        
        return self
    }
}
