import UIKit

class AutoLayoutViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(scrollView)

		view.addConstraints([
			scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 1),
			scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1),
		])

		let firstView = UIView(color: .systemBlue, height: 500)
		let secondView = UIView(color: .systemRed, height: 500)
		let stickyView = UIView(color: .systemGreen, height: 100)
		let fourthView = UIView(color: .systemOrange, height: 500)
		let fifthView = UIView(color: .systemPurple, height: 500)

		// We put the sticky view in a wrapper view.
		// The wrapper gets the same height as the third view, and the third view is matching |_|
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

		firstView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(firstView)

		secondView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(secondView)

		fourthView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(fourthView)

		fifthView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(fifthView)

		// We add this last to make sure that it always stays on top of the other views. Otherwise, it might render beneath them
		wrapperView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(wrapperView)

		scrollView.addConstraints([
			// One of the views, it does not matter which, has to lock to the width of the scrollView,
			// So that the `scrollView.contentLayoutGuide` has a width constraint
			firstView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

			firstView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			firstView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

			secondView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			secondView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

			wrapperView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			wrapperView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

			fourthView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			fourthView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

			fifthView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			fifthView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

			firstView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			secondView.topAnchor.constraint(equalToSystemSpacingBelow: firstView.bottomAnchor, multiplier: 1),
			wrapperView.topAnchor.constraint(equalToSystemSpacingBelow: secondView.bottomAnchor, multiplier: 1),
			fourthView.topAnchor.constraint(equalToSystemSpacingBelow: wrapperView.bottomAnchor, multiplier: 1),
			fifthView.topAnchor.constraint(equalToSystemSpacingBelow: fourthView.bottomAnchor, multiplier: 1),
			fifthView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
		])

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
