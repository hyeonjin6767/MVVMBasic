//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

enum DateFormatChecker: Error{
    case yearBoundary
    case monthBoundary
    case dayBoundary
    case isBlank
    case notInt
}


class BirthDayViewController: UIViewController {
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
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
        
        guard let year = yearTextField.text, let month = monthTextField.text, let day = dayTextField.text else {
            print("")
            return
        }
        do {
            let _ = try dateChecker(inputYear: year, inputMonth: month, inputDay: day)
            resultLabel.text = Birthday(year: Int(year)!, month: Int(month)!, day: Int(day)!)
        } catch .yearBoundary {
            resultLabel.text = "2000년 부터 2025년 중에 하나를 입력해주세요"
        } catch .monthBoundary {
            resultLabel.text = "1월부터 12월 중에 하나를 입력해주세요"
        } catch .dayBoundary {
            resultLabel.text = "1일부터 31일 중에 하나를 입력해주세요"
        } catch .isBlank {
            resultLabel.text = "입력이 완료되지 않았습니다"
        } catch .notInt {
            resultLabel.text = "숫자를 입력해주세요"
        } catch {
            resultLabel.text = "다른 에러가 발생했습니다"
        }
        
    }
    func dateChecker(inputYear: String, inputMonth: String, inputDay: String) throws(DateFormatChecker) -> Bool {
        
        guard !(inputYear.isEmpty) else {
            print("년도가 입력되지 않았습니다")
            throw .isBlank
        }
        guard !(inputMonth.isEmpty) else {
            print("월이 입력되지 않았습니다")
            throw .isBlank
        }
        guard !(inputDay.isEmpty) else {
            print("일이 입력되지 않았습니다")
            throw .isBlank
        }
        guard Int(inputYear) != nil else {
            print("년도가 숫자가 아닙니다")
            throw .notInt
        }
        guard Int(inputMonth) != nil else {
            print("월이 숫자가 아닙니다")
            throw .notInt
        }
        guard Int(inputDay) != nil else {
            print("일이 숫자가 아닙니다")
            throw .notInt
        }
        guard Int(inputYear)! > 1999, Int(inputYear)! < 2026 else {
            print("년도는 2000년부터 2025년까지 입니다")
            throw .yearBoundary
        }
        guard Int(inputMonth)! > 0, Int(inputMonth)! < 13 else {
            print("월은 1월부터 12월까지 입니다")
            throw .monthBoundary
        }
        guard Int(inputDay)! > 0, Int(inputDay)! < 32 else {
            print("일은 1일부터 31일까지 입니다")
            throw .dayBoundary
        }
        return true
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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
