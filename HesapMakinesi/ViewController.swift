import UIKit

class ViewController: UIViewController {
    
    var resultScreenFirstNumber: Double? = nil
    var currentOperation: String = ""
    var isDecimalMode: Bool = false // Ondalık sayı girişini takip etmek için bir bayrak
    var isNegativeMode: Bool = false // Negatif sayı girişini takip etmek için bir bayrak
    var memory: Double? // Bellek işlevleri için bir bellek değişkeni
        
    
    @IBOutlet weak var resultScreen: UILabel!
    
    
    @IBAction func numbers(_ sender: UIButton) {
        if resultScreen.text == "0" || currentOperation == "=" {
            resultScreen.text = String(sender.tag)
        } else {
            resultScreen.text = resultScreen.text! + String(sender.tag)
        }
    }
    
    @IBAction func OperateButtons(_ sender: UIButton) {
        if sender.tag == 10 { // Temizle düğmesi
                resultScreen.text = "0"
                resultScreenFirstNumber = 0
                currentOperation = ""
                isDecimalMode = false
                isNegativeMode = false
            } else if sender.tag == 11 { // Eşittir düğmesi
                performOperation()
                currentOperation = "="
                isDecimalMode = false
                isNegativeMode = false
            } else if sender.tag == 12 { // Nokta düğmesi
                if !isDecimalMode {
                    resultScreen.text = resultScreen.text! + "."
                    isDecimalMode = true
                }
            } else if sender.tag == 13 { // +/- düğmesi
                if let currentText = resultScreen.text, let currentNumber = Double(currentText) {
                    let newNumber = -currentNumber
                    resultScreen.text = formatNumber(newNumber)
                }
            } else if sender.tag == 14 { // % düğmesi
                if let currentNumber = Double(resultScreen.text!) {
                    let percentage = currentNumber / 100.0
                    resultScreen.text = formatNumber(percentage)
                }
            } else {
                if currentOperation != "" {
                    performOperation()
                }
                currentOperation = sender.titleLabel?.text ?? ""
                resultScreenFirstNumber = Double(resultScreen.text!) ?? 0
                resultScreen.text = "0"
                isDecimalMode = false
            }
    }
    // Sayıyı biçimlendirmek için bir yardımcı fonksiyon
    func formatNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 6
        return numberFormatter.string(from: NSNumber(value: number)) ?? "0"
    }
    
    func performOperation() {
        guard let currentText = resultScreen.text, let currentNumber = Double(currentText) else {
            return
        }
        
        switch currentOperation {
        case "+":
            resultScreenFirstNumber! += currentNumber
        case "-":
            resultScreenFirstNumber! -= currentNumber
        case "x":
            resultScreenFirstNumber! *= currentNumber
        case "÷":
            if currentNumber != 0 {
                resultScreenFirstNumber! /= currentNumber
            } else {
                resultScreen.text = "Error"
                return
            }
        default:
            break
        }
        // Sonucu ondalık olarak göster
        resultScreen.text = formatNumber(resultScreenFirstNumber!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
