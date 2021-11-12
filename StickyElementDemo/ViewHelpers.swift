import UIKit

extension UIView {
	convenience init(color: UIColor, height: CGFloat) {
		self.init()
		backgroundColor = color
		addConstraint(heightAnchor.constraint(equalToConstant: height))
	}
}
