//
//  ViewController.swift
//  menubarAppWithSB
//
//  Created by Murat Can KOÇ on 28.01.2022.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var input: NSTextField!
    @IBOutlet weak var type: NSSegmentedControl!
    @IBOutlet weak var output: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        typeChanged(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func typeChanged(_ sender: Any) {
        switch type.selectedSegment {
        case 0:
            output.stringValue = rot13(input.stringValue)
        case 1:
            output.stringValue = nextCharacter(input.stringValue)
        case 2:
            output.stringValue = strike(input.stringValue)
        default:
            output.stringValue = zalgo(input.stringValue)
        }
    }

    @IBAction func copyToPasteboard(_ sender: Any) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(output.stringValue, forType: .string)
    }

    func controlTextDidChange(_ obj: Notification) {
        typeChanged(self)
    }

    func rot13(_ input: String) -> String {
        return ROT13.string(input)
    }

    func nextCharacter(_ input: String) -> String {
        return NextCharacter.string(input)
    }

    func strike(_ input: String) -> String {
        var output = ""
        for letter in input {
            output.append(letter)

            output.append("\u{0335}")
        }
        return output
    }

    func zalgo(_ input: String, intensity: Int = Int.random(in: 10...30)) -> String {
        let combiningDiacriticMarks = 0x0300...0x036f
        let latinAlphabetUppercase = 0x0041...0x005a
        let latinAlphabetLowercase = 0x0061...0x007a

        var output: [UnicodeScalar] = []
        for scalar in input.unicodeScalars {
            output.append(scalar)
            guard (latinAlphabetUppercase).contains(numericCast(scalar.value)) ||
                  (latinAlphabetLowercase).contains(numericCast(scalar.value))
            else {
                continue
            }

            for _ in 0...(Int.random(in: 1...intensity)) {
                let randomScalarValue = Int.random(in: combiningDiacriticMarks)
                output.append(Unicode.Scalar(randomScalarValue)!)
            }
        }

        return String(String.UnicodeScalarView(output))
    }

    
}

