//
//  ViewController.swift
//  Calculator
//
//  Created by Aleksandar Vacić on 27.3.17..
//  Copyright © 2017. Radiant Tap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	//	MARK:- View outlets

	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet var digitButtons: [UIButton]!
	@IBOutlet var operatorButtons: [UIButton]!
	@IBOutlet weak var dotButton: UIButton!
	@IBOutlet weak var scienceView: UIView!


	//	MARK:- Data Model

	var firstOperand: Double?
	var secondOperand: Double?

	enum ArithmeticOperation {
		case add
		case subtract
		case multiply
		case divide

		case equals
	}
	var operation: ArithmeticOperation?

	var originalBackgroundColor: UIColor?

	lazy var formatter: NumberFormatter? = {
		let nf = NumberFormatter()
		return nf
	}()

//	lazy var formatter2 : NumberFormatter? = NumberFormatter()
}

//	MARK:- View lifecycle methods
extension ViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		setupDigitTapActions()
		setupOperatorTapActions()
		setupButtonTouchActions()
		initialUICleanup()
		setupDotButton()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
}

//	MARK:- UI setup

extension ViewController {
	func initialUICleanup() {
		resultLabel.text = nil
	}

	func setupDotButton() {
		dotButton.setTitle(Locale.current.decimalSeparator, for: .normal)
	}

	func setupButtonTouchActions() {
		let allButtons = digitButtons + operatorButtons + [dotButton]
		for btn in allButtons {
			btn.addTarget(self, action: #selector(ViewController.didTouch), for: .touchDown)
			btn.addTarget(self, action: #selector(ViewController.didUntouch), for: .touchUpOutside)
		}
	}


	func setupDigitTapActions() {
		for btn in digitButtons {
			btn.addTarget(self, action: #selector(ViewController.didTapDigit), for: .touchUpInside)
		}
	}

	func setupOperatorTapActions() {
		for btn in operatorButtons {
			btn.addTarget(self, action: #selector(ViewController.didTapOperator), for: .touchUpInside)
		}
	}
}

//	MARK:- Actions

extension ViewController {
	func didTouch(_ sender: UIButton) {
		originalBackgroundColor = sender.backgroundColor
		if let color = originalBackgroundColor {
			sender.backgroundColor = color.withAlphaComponent(0.9)
		}
	}

	func didUntouch(_ sender: UIButton) {
		sender.backgroundColor = originalBackgroundColor
		originalBackgroundColor = nil
	}


	func didTapDigit(_ sender: UIButton) {
		if let caption = sender.title( for: .normal) {
//			//	these 5 lines of code
//			if let str = resultLabel.text {
//				resultLabel.text = str + caption
//			} else {
//				resultLabel.text = caption
//			}
			//	is equivalent to this:
			let str = resultLabel.text ?? ""
			resultLabel.text = str + caption
//			//	also equivalent to this
//			resultLabel.text = (resultLabel.text ?? "") + caption

			let num = formatter?.number(from: str)?.doubleValue
			let strout = formatter?.string(for: num)

		} else {
			//	this is empty button == 0
		}

		didUntouch(sender)
	}

	func didTapOperator(_ sender: UIButton) {

		didUntouch(sender)
	}
}



