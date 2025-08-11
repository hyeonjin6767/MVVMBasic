//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

//enum AgeCheck: Error {
//    case overInt
//    case isBlank
//    case isString
//}

class AgeViewController: UIViewController {
    
    let viewModel = AgeViewModel()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
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
        
//        viewModel.errorCheckText = {
//            
//            self.view.endEditing(true)
//            self.label.text = self.viewModel.outputText
//        }
        
        viewModel.outputText.bind { _ in
            print("??")
            self.view.endEditing(true)
            self.label.text = self.viewModel.outputText.value
        }
    }
    
    @objc func resultButtonTapped() {
                
        viewModel.inputField.value = textField.text!
        
        //데이터 변화 신호 쏘기
//        viewModel.inputField = textField.text
        
        //view.endEditing(true)
//        guard let input = textField.text else {
//            print("공백입니다")
//            return
//        }
//        do {
//            let _ = try genericExercise(check: input)
//            label.text = "검색이 가능합니다"
//        } catch AgeCheck.overInt {
//            label.text = "나이는 0세에서 100세 사이입니다"
//        } catch AgeCheck.isBlank {
//            label.text = "빈칸입니다"
//        } catch AgeCheck.isString {
//            label.text = "숫자가 아닙니다"
//        } catch {
//            label.text = "다른 문제가 발생했습니다"
//        }
    }
    
//    func genericExercise(check: String) throws -> Bool {
//    
//        //옵셔널 문제로 체크하는 순서 주의!
//        guard !(check.isEmpty) else {
//            print("빈칸입니다.")
//            throw AgeCheck.isBlank
//        }
//        guard Int(check) != nil else {
//            print("숫자가 아닙니다.")
//            throw AgeCheck.isString
//        }
//        guard Int(check)! > 0 else {
//            print("나이는 0 혹은 마이너스가 될 수 없습니다.")
//            throw AgeCheck.overInt
//        }
//        guard Int(check)! <= 100 else {
//            print("나이는 100을 넘을 수 없습니다.")
//            throw AgeCheck.overInt
//        }
//        return true
//    }

    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
