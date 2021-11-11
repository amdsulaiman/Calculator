//
//  ViewController.swift
//  Calculator App
//
// 
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var holder:UIView!
    var firstNumber = 0
    var lastNumber = 0
    var Currentoperations :Operation?
    enum Operation {
        case add,subtract,multiply,division
    }
    
    private var resultlabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100 )
        return label
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNmberpad()
    }
    
    private func setupNmberpad(){
        let buttonsize: CGFloat = view.frame.size.width / 4
        let zerobutton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonsize, width: buttonsize*3, height: buttonsize))
        zerobutton.setTitle("0", for: .normal)
        zerobutton.setTitleColor(.black , for: .normal)
        zerobutton.backgroundColor = .white
        holder.addSubview(zerobutton)
        zerobutton.tag = 1
        zerobutton.addTarget(self, action: #selector(zerotapped), for: .touchUpInside)
        //zerobutton.layer.cornerRadius = 10
        
        for x in 0..<3 {
            let button1  = UIButton(frame: CGRect(x: buttonsize * CGFloat(x), y: holder.frame.size.height-(buttonsize*2), width: buttonsize, height: buttonsize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            
            button1.setTitle("\(x+1)", for: .normal)
            holder.addSubview(button1)
            //button1.layer.cornerRadius = 20
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            
            //            button1.layer.cornerRadius = 50
            //            button1.clipsToBounds = true
        }
        
        for x in 0..<3 {
            let button2  = UIButton(frame: CGRect(x: buttonsize * CGFloat(x), y: holder.frame.size.height-(buttonsize*3), width: buttonsize, height: buttonsize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            
            button2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button2)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            //button2.layer.cornerRadius = 20
            //            button2.layer.cornerRadius = 50
            //            button2.clipsToBounds = true
            
        }
        for x in 0..<3 {
            let button3  = UIButton(frame: CGRect(x: buttonsize * CGFloat(x), y: holder.frame.size.height-(buttonsize*4 ), width: buttonsize, height: buttonsize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            
            button3.setTitle("\(x+7)", for: .normal)
            holder.addSubview(button3)
            //button3.layer.cornerRadius = 20
            button3.tag = x+8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            //            button3.layer.cornerRadius = 50
            //            button3.clipsToBounds = true
            
        }
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonsize*5), width: view.frame.size.width - buttonsize, height: buttonsize))
        clearButton.setTitle("Clear All", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        //clearButton.layer.cornerRadius = 20
        holder.addSubview(clearButton)
        //clearButton.layer.cornerRadius = 10
        
        let operations = ["=","+", "-", "x", "/"]
        
        
        for x in 0..<5 {
            let button4  = UIButton(frame: CGRect(x: buttonsize * 3, y: holder.frame.size.height-(buttonsize * CGFloat(x+1) ), width: buttonsize, height: buttonsize))
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            
            button4.setTitle(operations[x], for: .normal)
            holder.addSubview(button4)
            button4.tag = x+1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            //            button4.layer.cornerRadius = 40
            //            button4.clipsToBounds = true
            
            
        }
        resultlabel.frame = CGRect(x: 0, y:clearButton.frame.origin.y - 110.0, width:  view.frame.size.width - 40, height: 100)
        holder.addSubview(resultlabel)
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    @objc func zerotapped()
    {
        
        if resultlabel.text != "0"{
            
            if let text = resultlabel.text {
                resultlabel.text = "\(text)\(0)"
            }
            
        }
    }
    @objc func clearResult(){
        resultlabel.text = "0"
        Currentoperations = nil
        firstNumber = 0
    }
    
    @objc func numberPressed(_ sender:UIButton){
        let tag = sender.tag - 1
        if resultlabel.text == "0"{
            resultlabel.text = "\(tag)"
        }
        else if let text = resultlabel.text {
            resultlabel.text = "\(text)\(tag)"
        }
        
    }
    @objc func operationPressed(_ sender:UIButton){
        let tag = sender.tag
        if let text = resultlabel.text, let value = Int(text),firstNumber == 0{
            firstNumber = value
            resultlabel.text = "0"
        }
        
        if tag == 1{
            
            if let operation = Currentoperations {
                var secondNumber = 0
                if let text = resultlabel.text, let value = Int(text){
                    secondNumber = value
                }
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultlabel.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultlabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultlabel.text = "\(result)"
                    break
                case .division:
                    let result = firstNumber / secondNumber
                    resultlabel.text = "\(result)"
                    break
                    
                    
                }
            }
            
            
        }
        else if   tag == 2{
            Currentoperations = .add
        }
        else if   tag == 3{
            Currentoperations = .subtract
            
        }
        
        else if tag == 4{
            Currentoperations = .multiply
        }
        else if   tag == 5
        {
            Currentoperations = .division
        }
        
    }
}
