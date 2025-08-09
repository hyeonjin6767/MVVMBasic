//
//  BirthdayViewModel.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/9/25.
//

import Foundation

enum DateFormatChecker: Error{
    case yearBoundary
    case monthBoundary
    case dayBoundary
    case isBlank
    case notInt
}

class BirthdayViewModel {
    
    var inputYear: String? = "" {
        didSet {
            print("inputYear신호 받음")
            print(oldValue)
            print(inputYear)
            validateError()
        }
    }
    var inputMonth: String? = "" {
        didSet {
            print("inputMonth신호 받음")
            print(oldValue)
            print(inputMonth)
            validateError()
        }
    }
    var inputDay: String? = "" {
        didSet {
            print("inputDay신호 받음")
            print(oldValue)
            print(inputDay)
            validateError()
        }
    }
    
    var birthdayClosure: (() -> Void)?
    
    var outputText: String = "" {
        didSet {
            print("outputText의 변화 감지")
            print(oldValue)
            print(outputText)
            birthdayClosure?()
        }
    }
    
    private func validateError() {
        
        guard let year = inputYear, let month = inputMonth, let day = inputDay else {
            print("공백입니다")
            return
        }
        do {
            let _ = try dateChecker(inputYear: year, inputMonth: month, inputDay: day)
            outputText = "\(Birthday(year: Int(year)!, month: Int(month)!, day: Int(day)!))"
        } catch .yearBoundary {
            outputText = "2000년 부터 2025년 중에 하나를 입력해주세요"
        } catch .monthBoundary {
            outputText = "1월부터 12월 중에 하나를 입력해주세요"
        } catch .dayBoundary {
            outputText = "1일부터 31일 중에 하나를 입력해주세요"
        } catch .isBlank {
            outputText = "입력이 완료되지 않았습니다"
        } catch .notInt {
            outputText = "숫자를 입력해주세요"
        } catch {
            outputText = "다른 에러가 발생했습니다"
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
    
   
}

extension BirthdayViewModel {
    
    func Birthday<T: Numeric>(year: T, month: T, day: T) -> String {
        return "\(year)년 \(month)월 \(day)일 + 130일입니다"
    }
}
