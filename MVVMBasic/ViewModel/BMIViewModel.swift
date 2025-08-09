//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/9/25.
//

import Foundation

enum BMIConditionError: Error {
    case isBlank
    case notInt
    case heightBoundary
    case weightBoundary
}

class BMIViewModel {
    
    var inputHeight: String? = "" {
        didSet {
            print("inputHeight신호 받음")
            print(oldValue)
            print(inputHeight)
            validateError()
        }
    }
    var inputWeight: String? = "" {
        didSet {
            print("inputWeight신호 받음")
            print(oldValue)
            print(inputWeight)
            validateError()
        }
    }
    
    var bmiClosure: (() -> Void)?
    
    var outputText: String = "" {
        didSet {
            print("validateError에서 outputText의 변화 감지")
            print(oldValue)
            print(outputText)
            bmiClosure?()
        }
    }
    
    private func validateError() {
    
        guard let height = inputHeight, let weight = inputWeight else {
            print("공백입니다")
            return
        }
        do {
            let _ = try boundaryCheck(inputHeight: height, inputWeight: weight)
            outputText = "BMI계산이 가능합니다\n BMI결과 : \(BMIcalculator(height: Double(height)!, weight: Double(weight)!))"
        } catch .heightBoundary {
            outputText = "키는 50cm에서 200cm사이 입니다"
        } catch .weightBoundary {
            outputText = "몸무게가 10kg에서 300kg 사이가 아닙니다"
        } catch .isBlank {
            outputText = "입력이 완료되지 않았습니다"
        } catch .notInt {
            outputText = "숫자가 아닙니다"
        } catch {
            outputText = "다른 에러가 발생했습니다"
            //showAlert(message: message)
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
    
}

extension BMIViewModel {
    
    func BMIcalculator<T: BinaryFloatingPoint>(height: T, weight: T) -> Int {
        
        let result = weight / ((height * 0.01) * (height * 0.01))
        return Int(result)
    }
    
}
