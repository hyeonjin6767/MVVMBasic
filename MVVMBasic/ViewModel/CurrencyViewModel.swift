//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/9/25.
//

import Foundation

class CurrencyViewModel {
    
    var inputMoney = Observable(value: "")
    
    init() {
        inputMoney.bind { _ in
            self.convertDollar()
        }
    }
    
    var outputDollar = Observable(value: "")
    
//    var inputMoney: String? = "" {
//        didSet {
//            print("inputMoney신호 받음")
//            print(oldValue)
//            print(inputMoney)
//            convertDollar()
//        }
//    }
//    
//    var  currencyClosure: (() -> Void)?
//    
//    var outputDollar: String? = "" {
//        didSet {
//            print("outputDollar신호 받음")
//            print(oldValue)
//            print(outputDollar)
//            currencyClosure?()
//        }
//    }
    
    private func convertDollar() {
        
//        guard let amountText = inputMoney, let amount = Double(amountText) else {
//            outputDollar.value = "올바른 금액을 입력해주세요"
//            return
//        }
        let amountText = inputMoney.value
        let amount = Double(amountText) ?? 0
        let exchangeRate = 1391.5 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputDollar.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
