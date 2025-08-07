//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum BMIConditionError: Error {
    case isBlank
    case notInt
    case heightBoundary
    case weightBoundary
}

class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        //label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
    
        guard let heightInput = heightTextField.text , let weightInput = weightTextField.text else {
            print("공백입니다")
            return
        }
        do {
            let _ = try boundaryCheck(inputHeight: heightInput, inputWeight: weightInput)
            resultLabel.text = "BMI계산이 가능합니다" // \(BMIcalculator(weight: Double(weightInput)!, height: Double(heightInput)!))"
        } catch .heightBoundary {
            resultLabel.text = "키는 50cm에서 200cm사이 입니다"
        } catch .weightBoundary {
            resultLabel.text = "몸무게가 10kg에서 300kg 사이가 아닙니다"
        } catch .isBlank {
            resultLabel.text = "입력이 완료되지 않았습니다"
        } catch .notInt {
            resultLabel.text = "숫자가 아닙니다"
        } catch {
            let message = "다른 에러가 발생했습니다"
            showAlert(message: message)
        }
    }
    
    func boundaryCheck(inputHeight: String, inputWeight: String) throws(BMIConditionError) -> Bool {
        
        guard !(inputHeight.isEmpty) else {
            print("키가 입력되지 않았습니다")
            throw .isBlank
        }
        guard !(inputWeight.isEmpty) else {
            print("몸무게가 입력되지 않았습니다")
            throw .isBlank
        }
        guard Int(inputHeight) != nil else {
            print("키가 숫자가 아닙니다")
            throw .notInt
        }
        guard Int(inputWeight) != nil else {
            print("몸무게가 숫자가 아닙니다")
            throw .notInt
        }
        guard Int(inputHeight)! >= 50,  Int(inputHeight)! <= 200 else {
            print("키가 50cm에서 200cm사이가 아닙니다")
            throw .heightBoundary
        }
        guard Int(inputWeight)! >= 1, Int(inputWeight)! <= 100 else {
            print("몸무게가 10kg에서 300kg 사이가 아닙니다")
            throw .weightBoundary
        }
        return true
    }
    
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
