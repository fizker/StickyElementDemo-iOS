import UIKit

class StackViewViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)

		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 8
		scrollView.addSubview(stackView)

		view.addConstraints([
			scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 1),
			scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1),

			stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
			stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),

			stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
		])

		let firstView = UIView(color: .systemBlue, height: 500)
		let secondView = UIView(color: .systemRed, height: 500)
		let stickyView = UIView(color: .systemGreen, height: 100)
		let fourthView = UIView(color: .systemOrange, height: 500)
		let fifthView = UIView(color: .systemPurple, height: 500)

		// We put the sticky view in a wrapper view.
		// The wrapper gets the same height as the third view, and the third view is matching | |
		// The point is that the wrapper reserves a spot in the layout for where the sticky view will rest.
		let wrapperView = UIView()
		stickyView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.addSubview(stickyView)
		let centerConstraint = stickyView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor)
		// We lower the priority, because we will be breaking this constraint to make the view sticky
		centerConstraint.priority = .defaultHigh
		wrapperView.addConstraints([
			stickyView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
			stickyView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
			centerConstraint,
			stickyView.heightAnchor.constraint(equalTo: wrapperView.heightAnchor),
		])

		stackView.addArrangedSubview(firstView)
		stackView.addArrangedSubview(secondView)
		stackView.addArrangedSubview(wrapperView)
		stackView.addArrangedSubview(fourthView)
		stackView.addArrangedSubview(fifthView)

		// We re-add the wrapperView as the last view, to ensure it is always rendering above the other views
		stackView.addSubview(wrapperView)

		// These are the constraints that will be doing the magic.
		// `scrollView.frameLayoutGuide` is the guide for the outer bounds.
		// This ties the sticky view to the bounds of the scroll view.

		// To have the stickyView only stick to one end, just remove the other constraint,
		// and the centerYAnchor constraint on the wrapperView will remain intact.
		scrollView.addConstraints([
			stickyView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.topAnchor),
			scrollView.frameLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stickyView.bottomAnchor),
		])
	}
}
