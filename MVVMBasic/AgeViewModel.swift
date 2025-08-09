//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/8/25.
//

import Foundation

enum AgeCheck: Error {
    case overInt
    case isBlank
    case isString
}

class AgeViewModel {
    //신호 전달 받음
    var inputField: String? = ""  {
        
        didSet {
            print("inputField")
            print(oldValue)
            print(inputField)
            resultErrorCheck()
        }
    }
    
    var errorCheckText: (() -> Void)?
    
    
    //최종 데이터 보내주기
    var outputText = "" {
        didSet {
            print("outputText")
            print(oldValue)
            print(outputText)
            errorCheckText?() //대기하고 있던 클로저를 데이터 변화가 감지 됐으니 실행시켜
        }
    }
    
    private func resultErrorCheck() {
        
        guard let input = inputField else {
            print("공백입니다")
            return
        }
        do {
            let _ = try validateUserInput(check: input)
            outputText = "검색이 가능합니다"
        } catch AgeCheck.overInt {
            outputText = "나이는 0세에서 100세 사이입니다"
        } catch AgeCheck.isBlank {
            outputText = "빈칸입니다"
        } catch AgeCheck.isString {
            outputText = "숫자가 아닙니다"
        } catch {
            outputText = "다른 문제가 발생했습니다"
        }
    }
    
    private func validateUserInput(check: String) throws -> Bool {
        
        guard !(check.isEmpty) else {
            print("빈칸입니다.")
            throw AgeCheck.isBlank
        }
        guard Int(check) != nil else {
            print("숫자가 아닙니다.")
            throw AgeCheck.isString
        }
        guard Int(check)! > 0 else {
            print("나이는 0 혹은 마이너스가 될 수 없습니다.")
            throw AgeCheck.overInt
        }
        guard Int(check)! <= 100 else {
            print("나이는 100을 넘을 수 없습니다.")
            throw AgeCheck.overInt
        }
        return true
    }

}
