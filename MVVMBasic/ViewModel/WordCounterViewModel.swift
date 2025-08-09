//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/9/25.
//

import Foundation

class WordCounterViewModel {
    
    var inputWord: String? {
        didSet {
            print("inputWord로 신호 받음")
            print(oldValue)
            print(inputWord)
            updateCount()
        }
    }
    
    var counterClosure: (() -> Void)?
    
    var outputText: String? {
        didSet {
            print("outputText로 신호 받음")
            print(oldValue)
            print(outputText)
            counterClosure?()
        }
    }
    
    private func updateCount() {
        let count = inputWord?.count
        outputText = "현재까지 \(count!)글자 작성중"
    }
}
